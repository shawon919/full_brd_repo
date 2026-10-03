import 'package:brd/admin-portion/AdminApiHandler/AdminApiHandler.dart';
import 'package:flutter/material.dart';

class UserContactManagement extends StatefulWidget {
  const UserContactManagement({
    super.key,
  });

  @override
  State<UserContactManagement> createState() =>
      _UserContactManagementState();
}

class _UserContactManagementState
    extends State<UserContactManagement> {

  final Adminapihandler apiHandler =
      Adminapihandler();

  // ============================================================
  // CONTROLLERS
  // ============================================================

  final TextEditingController userPhoneController =
      TextEditingController();

  final TextEditingController userEmailController =
      TextEditingController();

  final TextEditingController driverPhoneController =
      TextEditingController();

  final TextEditingController driverEmailController =
      TextEditingController();


  // ============================================================
  // USER DATA
  // ============================================================

  List<Map<String, dynamic>> allUsers = [];

  List<Map<String, dynamic>> normalUsers = [];

  List<Map<String, dynamic>> driverUsers = [];

  bool isLoading = true;


  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    loadUsers();
  }


  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {

    userPhoneController.dispose();

    userEmailController.dispose();

    driverPhoneController.dispose();

    driverEmailController.dispose();

    super.dispose();
  }


  // ============================================================
  // LOAD USERS FROM API HANDLER
  // ============================================================

  Future<void> loadUsers() async {

    setState(() {
      isLoading = true;
    });

    try {

      final List<Map<String, dynamic>> users =
          await apiHandler.getAllUsers();

      // ========================================================
      // USERS WHO ARE NOT DRIVERS
      // ========================================================

      final List<Map<String, dynamic>>
          usersWithoutDriver =
          users
              .where(
                (user) =>
                    user['is_driver'] != true,
              )
              .toList();

      // ========================================================
      // USERS WHO ARE DRIVERS
      // ========================================================

      final List<Map<String, dynamic>>
          usersWhoAreDrivers =
          users
              .where(
                (user) =>
                    user['is_driver'] == true,
              )
              .toList();

      if (!mounted) return;

      setState(() {

        allUsers = users;

        normalUsers =
            usersWithoutDriver;

        driverUsers =
            usersWhoAreDrivers;

        isLoading = false;
      });

    } catch (e) {

      print(
        "Load users error: $e",
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst(
              "Exception: ",
              "",
            ),
          ),
          backgroundColor: Colors.red,
          behavior:
              SnackBarBehavior.floating,
        ),
      );
    }
  }


  // ============================================================
  // CONFIRM BUTTON
  // ============================================================

  void confirmContactInformation() {

    final String userPhone =
        userPhoneController.text.trim();

    final String userEmail =
        userEmailController.text.trim();

    final String driverPhone =
        driverPhoneController.text.trim();

    final String driverEmail =
        driverEmailController.text.trim();


    if (userPhone.isEmpty ||
        userEmail.isEmpty ||
        driverPhone.isEmpty ||
        driverEmail.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill all four fields",
          ),
          backgroundColor: Colors.red,
          behavior:
              SnackBarBehavior.floating,
        ),
      );

      return;
    }


    print(
      "User Phone: $userPhone",
    );

    print(
      "User Email: $userEmail",
    );

    print(
      "Driver Phone: $driverPhone",
    );

    print(
      "Driver Email: $driverEmail",
    );


    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Information confirmed",
        ),
        backgroundColor:
            Color(0xFF800000),
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }


  // ============================================================
  // USER CARD
  // ============================================================

  Widget buildUserCard(
    Map<String, dynamic> user,
  ) {

    final String name =
        user['fullName']?.toString() ??
            "Unknown User";

    final String email =
        user['email']?.toString() ??
            "No email";

    final String phone =
        user['phone']?.toString() ??
            "No phone number";


    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      padding:
          const EdgeInsets.all(16),

      decoration:
          BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        border: Border.all(
          color:
              const Color(0xFFE5E7EB),
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(
              0.04,
            ),
            blurRadius: 8,
            offset:
                const Offset(0, 3),
          ),
        ],
      ),

      child: Row(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // ====================================================
          // ICON
          // ====================================================

          Container(

            height: 46,
            width: 46,

            decoration:
                BoxDecoration(

              color:
                  const Color(0xFFF7EDED),

              borderRadius:
                  BorderRadius.circular(12),
            ),

            child: const Icon(

              Icons.person_outline,

              color:
                  Color(0xFF800000),

              size: 25,
            ),
          ),

          const SizedBox(
            width: 12,
          ),

          // ====================================================
          // INFORMATION
          // ====================================================

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  name,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style:
                      const TextStyle(

                    fontSize: 16,

                    fontWeight:
                        FontWeight.w700,

                    color:
                        Color(0xFF1A1A1A),
                  ),
                ),

                const SizedBox(
                  height: 9,
                ),

                Row(

                  children: [

                    const Icon(

                      Icons.phone_outlined,

                      size: 15,

                      color:
                          Color(0xFF6B7280),
                    ),

                    const SizedBox(
                      width: 7,
                    ),

                    Expanded(

                      child: Text(

                        phone,

                        style:
                            const TextStyle(

                          fontSize: 13,

                          color:
                              Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 6,
                ),

                Row(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Icon(

                      Icons.email_outlined,

                      size: 15,

                      color:
                          Color(0xFF6B7280),
                    ),

                    const SizedBox(
                      width: 7,
                    ),

                    Expanded(

                      child: Text(

                        email,

                        maxLines: 2,

                        overflow:
                            TextOverflow.ellipsis,

                        style:
                            const TextStyle(

                          fontSize: 13,

                          color:
                              Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // ============================================================
  // PEOPLE SECTION
  // ============================================================

  Widget buildPeopleSection({

    required String title,

    required String subtitle,

    required IconData icon,

    required List<Map<String, dynamic>>
        users,
  }) {

    return Expanded(

      child: Container(

        decoration:
            BoxDecoration(

          color:
              const Color(0xFFF9FAFB),

          borderRadius:
              BorderRadius.circular(18),

          border: Border.all(
            color:
                const Color(0xFFE5E7EB),
          ),
        ),

        child: Column(

          children: [

            // ==================================================
            // HEADER
            // ==================================================

            Container(

              padding:
                  const EdgeInsets.all(18),

              decoration:
                  const BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.only(

                  topLeft:
                      Radius.circular(18),

                  topRight:
                      Radius.circular(18),
                ),
              ),

              child: Row(

                children: [

                  Container(

                    height: 44,
                    width: 44,

                    decoration:
                        BoxDecoration(

                      color:
                          const Color(0xFFF7EDED),

                      borderRadius:
                          BorderRadius.circular(12),
                    ),

                    child: Icon(

                      icon,

                      color:
                          const Color(0xFF800000),
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(

                          title,

                          style:
                              const TextStyle(

                            fontSize: 18,

                            fontWeight:
                                FontWeight.w700,

                            color:
                                Color(0xFF1A1A1A),
                          ),
                        ),

                        const SizedBox(
                          height: 3,
                        ),

                        Text(

                          subtitle,

                          style:
                              const TextStyle(

                            fontSize: 12,

                            color:
                                Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(

                    padding:
                        const EdgeInsets
                            .symmetric(

                      horizontal: 11,

                      vertical: 7,
                    ),

                    decoration:
                        BoxDecoration(

                      color:
                          const Color(0xFFF7EDED),

                      borderRadius:
                          BorderRadius.circular(20),
                    ),

                    child: Text(

                      "${users.length}",

                      style:
                          const TextStyle(

                        fontWeight:
                            FontWeight.w700,

                        color:
                            Color(0xFF800000),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              height: 1,
              color:
                  Color(0xFFE5E7EB),
            ),

            // ==================================================
            // LIST
            // ==================================================

            Expanded(

              child: users.isEmpty

                  ? const Center(

                      child: Column(

                        mainAxisSize:
                            MainAxisSize.min,

                        children: [

                          Icon(

                            Icons.people_outline,

                            size: 42,

                            color:
                                Color(0xFF9CA3AF),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Text(

                            "No users found",

                            style:
                                TextStyle(

                              color:
                                  Color(0xFF6B7280),

                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )

                  : ListView.builder(

                      padding:
                          const EdgeInsets.all(14),

                      itemCount:
                          users.length,

                      itemBuilder:
                          (context, index) {

                        return buildUserCard(
                          users[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }


  // ============================================================
  // INPUT FIELD
  // ============================================================

  Widget buildInputField({

    required String label,

    required String hint,

    required IconData icon,

    required TextEditingController
        controller,

    TextInputType keyboardType =
        TextInputType.text,
  }) {

    return Column(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Text(

          label,

          style:
              const TextStyle(

            fontSize: 13,

            fontWeight:
                FontWeight.w700,

            color:
                Color(0xFF1A1A1A),
          ),
        ),

        const SizedBox(
          height: 8,
        ),

        TextField(

          controller:
              controller,

          keyboardType:
              keyboardType,

          decoration:
              InputDecoration(

            hintText:
                hint,

            hintStyle:
                const TextStyle(

              color:
                  Color(0xFF9CA3AF),

              fontSize: 13,
            ),

            prefixIcon:
                Icon(

              icon,

              size: 20,

              color:
                  const Color(0xFF800000),
            ),

            filled: true,

            fillColor:
                const Color(0xFFF9FAFB),

            contentPadding:
                const EdgeInsets
                    .symmetric(

              horizontal: 14,

              vertical: 15,
            ),

            border:
                OutlineInputBorder(

              borderRadius:
                  BorderRadius.circular(11),

              borderSide:
                  const BorderSide(

                color:
                    Color(0xFFE5E7EB),
              ),
            ),

            enabledBorder:
                OutlineInputBorder(

              borderRadius:
                  BorderRadius.circular(11),

              borderSide:
                  const BorderSide(

                color:
                    Color(0xFFE5E7EB),
              ),
            ),

            focusedBorder:
                OutlineInputBorder(

              borderRadius:
                  BorderRadius.circular(11),

              borderSide:
                  const BorderSide(

                color:
                    Color(0xFF800000),

                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }


  // ============================================================
  // CENTER FORM
  // ============================================================

  Widget buildContactForm() {

    return Container(

      width: 340,

      padding:
          const EdgeInsets.all(22),

      decoration:
          BoxDecoration(

        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(18),

        border: Border.all(
          color:
              const Color(0xFFE5E7EB),
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withOpacity(
              0.05,
            ),

            blurRadius: 18,

            offset:
                const Offset(0, 6),
          ),
        ],
      ),

      child: Column(

        mainAxisSize:
            MainAxisSize.min,

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // ==================================================
          // FORM HEADER
          // ==================================================

          Row(

            children: [

              Container(

                height: 44,
                width: 44,

                decoration:
                    BoxDecoration(

                  color:
                      const Color(0xFF800000),

                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: const Icon(

                  Icons.contact_phone_outlined,

                  color:
                      Colors.white,

                  size: 23,
                ),
              ),

              const SizedBox(
                width: 12,
              ),

              const Expanded(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(

                      "Contact Details",

                      style:
                          TextStyle(

                        fontSize: 18,

                        fontWeight:
                            FontWeight.w700,

                        color:
                            Color(0xFF1A1A1A),
                      ),
                    ),

                    SizedBox(
                      height: 3,
                    ),

                    Text(

                      "Enter user and driver details",

                      style:
                          TextStyle(

                        fontSize: 11,

                        color:
                            Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 22,
          ),

          // ==================================================
          // USER
          // ==================================================

          const Text(

            "USER INFORMATION",

            style:
                TextStyle(

              fontSize: 11,

              fontWeight:
                  FontWeight.w800,

              letterSpacing: 1,

              color:
                  Color(0xFF800000),
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          buildInputField(

            label:
                "User Mobile Number",

            hint:
                "Enter user mobile number",

            icon:
                Icons.phone_outlined,

            controller:
                userPhoneController,

            keyboardType:
                TextInputType.phone,
          ),

          const SizedBox(
            height: 14,
          ),

          buildInputField(

            label:
                "User Email",

            hint:
                "Enter user email",

            icon:
                Icons.email_outlined,

            controller:
                userEmailController,

            keyboardType:
                TextInputType.emailAddress,
          ),

          const SizedBox(
            height: 22,
          ),

          Container(

            height: 1,

            color:
                const Color(0xFFE5E7EB),
          ),

          const SizedBox(
            height: 22,
          ),

          // ==================================================
          // DRIVER
          // ==================================================

          const Text(

            "DRIVER INFORMATION",

            style:
                TextStyle(

              fontSize: 11,

              fontWeight:
                  FontWeight.w800,

              letterSpacing: 1,

              color:
                  Color(0xFF800000),
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          buildInputField(

            label:
                "Driver Mobile Number",

            hint:
                "Enter driver mobile number",

            icon:
                Icons.phone_outlined,

            controller:
                driverPhoneController,

            keyboardType:
                TextInputType.phone,
          ),

          const SizedBox(
            height: 14,
          ),

          buildInputField(

            label:
                "Driver Email",

            hint:
                "Enter driver email",

            icon:
                Icons.email_outlined,

            controller:
                driverEmailController,

            keyboardType:
                TextInputType.emailAddress,
          ),

          const SizedBox(
            height: 24,
          ),

          // ==================================================
          // CONFIRM
          // ==================================================

          SizedBox(

            width:
                double.infinity,

            height: 48,

            child:
                ElevatedButton(

              onPressed:
                  confirmContactInformation,

              style:
                  ElevatedButton.styleFrom(

                backgroundColor:
                    const Color(0xFF800000),

                foregroundColor:
                    Colors.white,

                elevation: 0,

                shape:
                    RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(11),
                ),
              ),

              child:
                  const Text(

                "Confirm",

                style:
                    TextStyle(

                  fontSize: 14,

                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF5F6F8),

      appBar:
          AppBar(

        elevation: 0,

        backgroundColor:
            const Color(0xFF800000),

        foregroundColor:
            Colors.white,

        title:
            const Text(

          "User & Driver Management",

          style:
              TextStyle(

            fontWeight:
                FontWeight.w700,

            fontSize: 19,
          ),
        ),

        actions: [

          IconButton(

            tooltip:
                "Refresh",

            onPressed:
                isLoading
                    ? null
                    : loadUsers,

            icon:
                const Icon(
              Icons.refresh,
            ),
          ),

          const SizedBox(
            width: 8,
          ),
        ],
      ),

      body:
          isLoading

              ? const Center(

                  child:
                      CircularProgressIndicator(

                    color:
                        Color(0xFF800000),
                  ),
                )

              : LayoutBuilder(

                  builder:
                      (context, constraints) {

                    // ==================================================
                    // DESKTOP
                    // ==================================================

                    if (constraints.maxWidth >=
                        1100) {

                      return Padding(

                        padding:
                            const EdgeInsets.all(
                          22,
                        ),

                        child:
                            Row(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .stretch,

                          children: [

                            // LEFT
                            buildPeopleSection(

                              title:
                                  "Users",

                              subtitle:
                                  "Registered users",

                              icon:
                                  Icons
                                      .people_outline,

                              users:
                                  normalUsers,
                            ),

                            const SizedBox(
                              width: 18,
                            ),

                            // CENTER
                            SingleChildScrollView(

                              padding:
                                  const EdgeInsets
                                      .only(
                                bottom: 20,
                              ),

                              child:
                                  buildContactForm(),
                            ),

                            const SizedBox(
                              width: 18,
                            ),

                            // RIGHT
                            buildPeopleSection(

                              title:
                                  "Drivers",

                              subtitle:
                                  "Registered drivers",

                              icon:
                                  Icons
                                      .directions_car_outlined,

                              users:
                                  driverUsers,
                            ),
                          ],
                        ),
                      );
                    }


                    // ==================================================
                    // SMALLER SCREEN
                    // ==================================================

                    return SingleChildScrollView(

                      padding:
                          const EdgeInsets.all(
                        18,
                      ),

                      child:
                          Column(

                        children: [

                          buildContactForm(),

                          const SizedBox(
                            height: 20,
                          ),

                          SizedBox(

                            height: 500,

                            child:
                                buildPeopleSection(

                              title:
                                  "Users",

                              subtitle:
                                  "Registered users",

                              icon:
                                  Icons
                                      .people_outline,

                              users:
                                  normalUsers,
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          SizedBox(

                            height: 500,

                            child:
                                buildPeopleSection(

                              title:
                                  "Drivers",

                              subtitle:
                                  "Registered drivers",

                              icon:
                                  Icons
                                      .directions_car_outlined,

                              users:
                                  driverUsers,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}