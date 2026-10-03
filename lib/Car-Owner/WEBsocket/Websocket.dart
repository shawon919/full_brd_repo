import 'package:web_socket_channel/web_socket_channel.dart';

class Websocket {
  WebSocketChannel? channel;

  void connect(int id) {
    final uri = Uri.parse(
      "wss://nonideologically-minuscular-hoyt.ngrok-free.dev/ws/create_user/$id/",
    );

    channel = WebSocketChannel.connect(uri);
    print("WebSocket connected for id $id");
  }

  void sendMessage(String message) {
    channel?.sink.add(message);
  }

  void disconnect() {
    channel?.sink.close();
    channel = null;
    print("WebSocket disconnected");
  }
}