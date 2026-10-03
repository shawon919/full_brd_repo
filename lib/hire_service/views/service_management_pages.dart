import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../api/hire_service_api.dart';
import '../models/driver_service_model.dart';

enum LocationMode { owner, admin, driver }

class AdminActiveServicesPage extends StatefulWidget {
  const AdminActiveServicesPage({super.key});
  @override State<AdminActiveServicesPage> createState() => _AdminActiveServicesPageState();
}

class _AdminActiveServicesPageState extends State<AdminActiveServicesPage> {
  final api = HireServiceApi();
  List<DriverServiceModel> items = [];
  bool loading = true;

  @override void initState() { super.initState(); load(); }
  Future<void> load() async {
    setState(() => loading = true);
    try { items = (await api.getAdminDriverServices()).where((x) => x.status == 'active').toList(); }
    catch (e) { _msg(e); }
    finally { if (mounted) setState(() => loading = false); }
  }
  void _msg(Object e) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))));

  Future<void> terminate(DriverServiceModel x) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Terminate Driver Service'),
        content: Text('Terminate ${x.driverName} service for ${x.ownerName}? The service will remain in history and both sides can be assigned again.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Terminate')),
        ],
      ),
    );
    if (ok != true) return;
    try { await api.terminateDriverService(x.uuid); _msg('Service terminated successfully.'); await load(); }
    catch (e) { _msg(e); }
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Active Services')),
      body: RefreshIndicator(
        onRefresh: load,
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(20), itemCount: items.length,
                itemBuilder: (_, i) {
                  final x = items[i];
                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: const CircleAvatar(child: Icon(Icons.local_taxi_rounded)),
                      title: Text(x.driverName, style: const TextStyle(fontWeight: FontWeight.w800)),
                      subtitle: Text('Owner: ${x.ownerName}\nSalary: ৳${x.salary.toStringAsFixed(2)}\nStarted: ${x.joiningDate}'),
                      isThreeLine: true,
                      trailing: Wrap(
                        spacing: 5,
                        children: [
                          IconButton(tooltip: 'Live location', onPressed: () => Get.to(() => ServiceLiveLocationPage(service: x, mode: LocationMode.admin)), icon: const Icon(Icons.location_on_outlined)),
                          IconButton(tooltip: 'Terminate', onPressed: () => terminate(x), icon: const Icon(Icons.cancel_outlined)),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class ServiceLiveLocationPage extends StatefulWidget {
  final DriverServiceModel service;
  final LocationMode mode;
  const ServiceLiveLocationPage({super.key, required this.service, required this.mode});
  @override State<ServiceLiveLocationPage> createState() => _ServiceLiveLocationPageState();
}

class _ServiceLiveLocationPageState extends State<ServiceLiveLocationPage> {
  WebSocketChannel? channel;
  StreamSubscription? subscription;
  Timer? timer;
  final box = GetStorage();
  final MapController mapController = MapController();

  double? lat;
  double? lng;
  DateTime? locationTime;
  String updated = 'Waiting for driver location…';
  String connectionStatus = 'Connecting…';
  bool sharing = false;
  bool mapReady = false;
  bool reconnecting = false;

  // A neutral starting point is used only until the driver's first GPS fix.
  static const LatLng defaultCenter = LatLng(23.8103, 90.4125);

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    final token = (box.read('access_token') ?? '').toString();
    if (token.isEmpty) {
      if (mounted) setState(() => connectionStatus = 'Authentication token missing');
      return;
    }

    final uri = Uri.parse(
      'wss://nonideologically-minuscular-hoyt.ngrok-free.dev/ws/service-location/'
      '${widget.service.uuid}/?token=$token',
    );

    try {
      final socket = WebSocketChannel.connect(uri);
      channel = socket;
      subscription?.cancel();
      subscription = socket.stream.listen(
        _handleSocketMessage,
        onError: (Object error) {
          if (mounted) setState(() => connectionStatus = 'Connection error');
          _scheduleReconnect();
        },
        onDone: () {
          if (mounted) setState(() => connectionStatus = 'Disconnected');
          _scheduleReconnect();
        },
        cancelOnError: false,
      );
      if (mounted) setState(() => connectionStatus = 'Connected');
    } catch (_) {
      if (mounted) setState(() => connectionStatus = 'Connection failed');
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    if (reconnecting || !mounted) return;
    reconnecting = true;
    Future.delayed(const Duration(seconds: 3), () {
      reconnecting = false;
      if (mounted) connect();
    });
  }

  void _handleSocketMessage(dynamic raw) {
    try {
      final data = jsonDecode(raw.toString());

      // First connection may return the persisted last-known location.
      if (data['type'] == 'initial_location') {
        final initial = data['location'];
        if (initial is Map) {
          _applyLocation(initial);
        }
        return;
      }

      // Subsequent messages are live driver GPS updates.
      if (data['latitude'] != null && data['longitude'] != null) {
        _applyLocation(data);
      }
    } catch (_) {}
  }

  void _applyLocation(Map data) {
    final nextLat = double.tryParse(data['latitude'].toString());
    final nextLng = double.tryParse(data['longitude'].toString());
    if (nextLat == null || nextLng == null) return;
    if (nextLat < -90 || nextLat > 90 || nextLng < -180 || nextLng > 180) return;

    DateTime? parsedTime;
    final rawTime = data['updated_at'];
    if (rawTime != null) {
      parsedTime = DateTime.tryParse(rawTime.toString());
    }

    if (mounted) {
      setState(() {
        lat = nextLat;
        lng = nextLng;
        locationTime = parsedTime ?? DateTime.now();
        updated = 'Live • ${_formatTime(locationTime!)}';
        connectionStatus = 'Connected • Live';
      });
    }

    if (mapReady) {
      mapController.move(LatLng(nextLat, nextLng), 16);
    }
  }

  String _formatTime(DateTime value) {
    final local = value.toLocal();
    final h = local.hour.toString().padLeft(2, '0');
    final m = local.minute.toString().padLeft(2, '0');
    final sec = local.second.toString().padLeft(2, '0');
    return '$h:$m:$sec';
  }

  Future<void> startSharing() async {
    if (widget.mode != LocationMode.driver || sharing) return;

    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        if (mounted) {
          setState(() {
            updated = 'Turn on GPS/location on this phone';
            connectionStatus = 'GPS is off';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please turn on Location/GPS and press Start Sharing again.')),
          );
        }
        await Geolocator.openLocationSettings();
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        if (mounted) {
          setState(() {
            updated = 'Location permission denied';
            connectionStatus = 'Permission denied';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission is required to share your live location.')),
          );
        }
        return;
      }
      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          setState(() {
            updated = 'Location permission blocked';
            connectionStatus = 'Permission blocked';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Location permission is blocked. Open app settings and allow Location.'),
              action: SnackBarAction(label: 'Settings', onPressed: Geolocator.openAppSettings),
            ),
          );
        }
        return;
      }

      if (channel == null) {
        connect();
        await Future.delayed(const Duration(milliseconds: 500));
      }

      // Get a real GPS fix before changing the button to "Stop Sharing".
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
        ),
      );

      final payload = jsonEncode({
        'latitude': position.latitude,
        'longitude': position.longitude,
      });
      channel?.sink.add(payload);

      if (mounted) {
        setState(() {
          sharing = true;
          lat = position.latitude;
          lng = position.longitude;
          locationTime = DateTime.now();
          updated = 'Sharing • ${_formatTime(locationTime!)}';
          connectionStatus = 'Connected • Sharing';
        });
      }

      timer?.cancel();
      timer = Timer.periodic(const Duration(seconds: 5), (_) {
        _sendCurrentLocation();
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          sharing = false;
          updated = 'Could not get GPS location';
          connectionStatus = 'Location error';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not start location sharing: $e')),
        );
      }
    }
  }

  Future<void> _sendCurrentLocation() async {
    if (widget.mode != LocationMode.driver || !sharing) return;
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
        ),
      );
      channel?.sink.add(jsonEncode({
        'latitude': position.latitude,
        'longitude': position.longitude,
      }));

      if (mounted) {
        setState(() {
          lat = position.latitude;
          lng = position.longitude;
          locationTime = DateTime.now();
          updated = 'Sharing • ${_formatTime(locationTime!)}';
          connectionStatus = 'Connected • Sharing';
        });
      }
      if (mapReady) {
        mapController.move(LatLng(position.latitude, position.longitude), 16);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          updated = 'GPS update failed';
          connectionStatus = 'GPS error';
        });
      }
    }
  }

  void stopSharing() {
    timer?.cancel();
    timer = null;
    if (mounted) setState(() => sharing = false);
  }

  @override
  void dispose() {
    timer?.cancel();
    subscription?.cancel();
    channel?.sink.close();
    super.dispose();
  }

  String _roleMessage() {
    switch (widget.mode) {
      case LocationMode.admin:
        return 'You are monitoring the assigned driver in real time.';
      case LocationMode.owner:
        return 'You are viewing your assigned driver’s live location.';
      case LocationMode.driver:
        return 'Your live location is shared with the assigned owner and authorized admin while this service is active.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDriver = widget.mode == LocationMode.driver;
    final hasLocation = lat != null && lng != null;
    final current = hasLocation ? LatLng(lat!, lng!) : defaultCenter;

    return Scaffold(
      appBar: AppBar(
        title: Text(isDriver ? 'Share Live Location' : 'Driver Live Location'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text(
                connectionStatus,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: current,
                    initialZoom: hasLocation ? 16 : 6,
                    onMapReady: () {
                      mapReady = true;
                      if (hasLocation) {
                        mapController.move(current, 16);
                      }
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.brd.brd',
                    ),
                    if (hasLocation)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: current,
                            width: 64,
                            height: 78,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black26)],
                                  ),
                                  child: Text(
                                    widget.service.driverName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const Icon(Icons.location_on, size: 44, color: Colors.red),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    color: Colors.white.withValues(alpha: 0.85),
                    child: const Text(
                      '© OpenStreetMap contributors',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  top: 16,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          const Icon(Icons.local_taxi_rounded, size: 30),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.service.driverName, style: const TextStyle(fontWeight: FontWeight.w800)),
                                Text('Owner: ${widget.service.ownerName}', style: const TextStyle(fontSize: 12)),
                                Text(updated, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.circle,
                            size: 12,
                            color: hasLocation ? Colors.green : Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (!hasLocation)
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 24,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Text(
                          isDriver
                              ? 'Waiting for your GPS location…'
                              : 'Waiting for the driver to share a GPS location…',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                Text(_roleMessage(), style: const TextStyle(fontSize: 13, color: Colors.black54)),
                if (hasLocation) ...[
                  const SizedBox(height: 6),
                  Text(
                    '${lat!.toStringAsFixed(6)}, ${lng!.toStringAsFixed(6)}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
                if (isDriver) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: sharing ? stopSharing : startSharing,
                      icon: Icon(sharing ? Icons.stop : Icons.my_location),
                      label: Text(sharing ? 'Stop Sharing' : 'Start Sharing'),
                    ),
                  ),
                ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OwnerServiceHistoryPage extends StatefulWidget {
  const OwnerServiceHistoryPage({super.key});
  @override State<OwnerServiceHistoryPage> createState() => _OwnerServiceHistoryPageState();
}
class _OwnerServiceHistoryPageState extends State<OwnerServiceHistoryPage> {
  final api = HireServiceApi(); List<DriverServiceModel> items = []; bool loading = true;
  @override void initState() { super.initState(); load(); }
  Future<void> load() async { try { items = await api.getMyDriverServiceHistory(); } catch (_) {} finally { if (mounted) setState(() => loading = false); } }
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Service History')),
      body: loading ? const Center(child: CircularProgressIndicator()) : RefreshIndicator(
        onRefresh: load,
        child: ListView.builder(
          padding: const EdgeInsets.all(20), itemCount: items.length,
          itemBuilder: (_, i) {
            final x = items[i]; final active = x.status == 'active';
            return Card(child: ListTile(
              title: Text(x.driverName, style: const TextStyle(fontWeight: FontWeight.w800)),
              subtitle: Text('Salary: ৳${x.salary.toStringAsFixed(2)}\n${x.joiningDate} → ${x.endingDate.isEmpty ? 'Active' : x.endingDate}\nStatus: ${x.status.toUpperCase()}'),
              isThreeLine: true,
              trailing: active ? IconButton(icon: const Icon(Icons.location_on_outlined), onPressed: () => Get.to(() => ServiceLiveLocationPage(service: x, mode: LocationMode.owner))) : null,
            ));
          },
        ),
      ),
    );
  }
}

class AdminOperationalLocationsPage extends StatefulWidget {
  const AdminOperationalLocationsPage({super.key});
  @override State<AdminOperationalLocationsPage> createState() => _AdminOperationalLocationsPageState();
}
class _AdminOperationalLocationsPageState extends State<AdminOperationalLocationsPage> {
  final api = HireServiceApi(); List<DriverServiceModel> items = []; bool loading = true;
  @override void initState() { super.initState(); load(); }
  Future<void> load() async { try { items = (await api.getAdminDriverServices()).where((x) => x.status == 'active').toList(); } catch (_) {} finally { if (mounted) setState(() => loading = false); } }
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Operational Driver Locations')),
      body: loading ? const Center(child: CircularProgressIndicator()) : RefreshIndicator(
        onRefresh: load,
        child: ListView.builder(
          padding: const EdgeInsets.all(20), itemCount: items.length,
          itemBuilder: (_, i) { final x = items[i]; return Card(child: ListTile(
            title: Text(x.driverName, style: const TextStyle(fontWeight: FontWeight.w800)),
            subtitle: Text('Owner: ${x.ownerName}\nService: ${x.uuid}'), isThreeLine: true,
            trailing: ElevatedButton.icon(onPressed: () => Get.to(() => ServiceLiveLocationPage(service: x, mode: LocationMode.admin)), icon: const Icon(Icons.location_on_outlined), label: const Text('Monitor')),
          )); },
        ),
      ),
    );
  }
}
