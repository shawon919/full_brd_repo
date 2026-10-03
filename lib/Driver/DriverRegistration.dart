import 'dart:io';

import 'package:brd/Driver/Drivergetxcontroller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';


class Driverregistration extends StatelessWidget {
  Driverregistration({super.key});

  static const Color maroon = Color(0xFF800000);
  static const Color maroonDark = Color(0xFF5C0000);
  static const Color surface = Color(0xFFF7F7F9);
  static const Color ink = Color(0xFF1A1A1A);
  static const Color sub = Color(0xFF6B7280);
  static const Color line = Color(0xFFE7E7EC);

  final Drivergetxcontroller controller =
      Get.put(Drivergetxcontroller());

  final ImagePicker picker = ImagePicker();

  final Map<String, String> docs = {
    'Driving License — Front': 'dl_front',
    'Driving License — Back': 'dl_back',
    'NID — Front': 'nid_front',
    'NID — Back': 'nid_back',
    'Professional CV': 'cv',
  };

  int get filled {
    int c = 0;

    if (controller.fullNameController.text.trim().isNotEmpty) c++;
    if (controller.emailController.text.trim().isNotEmpty) c++;
    if (controller.phoneController.text.trim().isNotEmpty) c++;
    if (controller.descriptionController.text.trim().isNotEmpty) c++;
    if (controller.passwordController.text.trim().isNotEmpty) c++;

    if (controller.dlFrontFile.value != null) c++;
    if (controller.dlBackFile.value != null) c++;
    if (controller.nidFrontFile.value != null) c++;
    if (controller.nidBackFile.value != null) c++;
    if (controller.cvFile.value != null) c++;

    return c;
  }

  double get progress => filled / 10;

  Future<void> pickImage(String type) async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile == null) return;

    final file = File(pickedFile.path);

    switch (type) {
      case 'Driving License — Front':
        controller.dlFrontFile.value = file;
        break;

      case 'Driving License — Back':
        controller.dlBackFile.value = file;
        break;

      case 'NID — Front':
        controller.nidFrontFile.value = file;
        break;

      case 'NID — Back':
        controller.nidBackFile.value = file;
        break;
    }
  }


Future<void> pickCV() async {
  final XFile? pickedFile = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 70,
  );

  if (pickedFile == null) return;

  controller.cvFile.value = File(pickedFile.path);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surface,
      body: SafeArea(
        bottom: false,
        child: Form(
          onChanged: () {},
          child: CustomScrollView(
            slivers: [
              _buildHeader(),
              SliverPadding(
                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  140,
                ),
                sliver: SliverList(
                  delegate:
                      SliverChildListDelegate([
                    _stepCard(
                      step: '01',
                      title:
                          'Personal Information',
                      subtitle:
                          'Tell us about yourself',
                      child: Column(
                        children: [
                          _field(
                            controller: controller
                                .fullNameController,
                            label:
                                'Full Legal Name',
                            hint:
                                'As per your national ID',
                            icon: Icons
                                .badge_outlined,
                          ),
                          const SizedBox(
                              height: 14),
                          _field(
                            controller: controller
                                .emailController,
                            label:
                                'Email Address',
                            hint:
                                'name@example.com',
                            icon: Icons
                                .alternate_email,
                            keyboardType:
                                TextInputType
                                    .emailAddress,
                          ),
                          const SizedBox(
                              height: 14),
                          _field(
                            controller: controller
                                .phoneController,
                            label:
                                'Contact Number',
                            hint:
                                '+880 1XXX-XXXXXX',
                            icon: Icons
                                .phone_outlined,
                            keyboardType:
                                TextInputType
                                    .phone,
                            inputFormatters: [
                              FilteringTextInputFormatter
                                  .allow(
                                RegExp(
                                  r'[0-9+\-\s]',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 14),
                          _field(
                            controller: controller
                                .descriptionController,
                            label:
                                'About You',
                            hint:
                                'Driving experience, languages, vehicle type…',
                            icon: Icons
                                .short_text_rounded,
                            maxLines: 4,
                          ),
                          const SizedBox(
                              height: 14),
                          _field(
                            controller: controller
                                .passwordController,
                            label: 'Password',
                            hint:
                                'Enter secure password',
                            icon: Icons
                                .lock_outline,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _stepCard(
                      step: '02',
                      title:
                          'Verification Documents',
                      subtitle:
                          'Clear photos. Max 5 MB each.',
                      child: Column(
                        children: docs.keys
                            .map(
                              (k) => Padding(
                                padding:
                                    const EdgeInsets
                                        .only(
                                  bottom: 10,
                                ),
                                child:
                                    _docTile(k),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _agreementCard(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: _bottomBar(context),
    );
  }

  Widget _buildHeader() {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      stretch: true,
      backgroundColor: maroon,
      foregroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
        ),
        onPressed: () => Get.back(),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.help_outline_rounded,
          ),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding:
            const EdgeInsetsDirectional.only(
          start: 56,
          bottom: 16,
        ),
        title: Text(
          'Driver Application',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [maroon, maroonDark],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -60,
                top: -40,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                        .withOpacity(0.06),
                  ),
                ),
              ),
              Positioned(
                left: -40,
                bottom: -60,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                        .withOpacity(0.04),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  60,
                  20,
                  60,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.18),
                        borderRadius:
                            BorderRadius.circular(
                                20),
                      ),
                      child: Text(
                        'PARTNER ONBOARDING',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          letterSpacing: 1.5,
                          fontWeight:
                              FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Become a Driver',
                      style: GoogleFonts.inter(
                        fontSize: 26,
                        fontWeight:
                            FontWeight.w800,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Complete the steps below to get verified',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.white
                            .withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize:
            const Size.fromHeight(46),
        child: Obx(() {
          return Container(
            color: surface,
            padding:
                const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(
                            99),
                    child:
                        LinearProgressIndicator(
                      value:
                          progress.clamp(0, 1),
                      minHeight: 6,
                      backgroundColor: line,
                      valueColor:
                          const AlwaysStoppedAnimation(
                        maroon,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${(progress * 100).round()}%',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w700,
                    color: maroon,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _stepCard({
    required String step,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
        border: Border.all(color: line),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color:
                      maroon.withOpacity(0.08),
                  borderRadius:
                      BorderRadius.circular(
                          12),
                ),
                alignment: Alignment.center,
                child: Text(
                  step,
                  style: GoogleFonts.inter(
                    color: maroon,
                    fontWeight:
                        FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w700,
                        color: ink,
                      ),
                    ),
                    Text(
                      subtitle,
                      style:
                          GoogleFonts.inter(
                        fontSize: 12,
                        color: sub,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }

  Widget _field({
    required TextEditingController
        controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>?
        inputFormatters,
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: ink,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters:
              inputFormatters,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: ink,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                GoogleFonts.inter(
              fontSize: 13,
              color: sub,
            ),
            prefixIcon: Icon(
              icon,
              size: 18,
              color: maroon,
            ),
            filled: true,
            fillColor: surface,
            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: line),
            ),
            enabledBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: line),
            ),
            focusedBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(12),
              borderSide:
                  const BorderSide(
                color: maroon,
                width: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _docTile(String name) {
    return Obx(() {
      bool uploaded = false;

      switch (name) {
        case 'Driving License — Front':
          uploaded =
              controller.dlFrontFile.value !=
                  null;
          break;

        case 'Driving License — Back':
          uploaded =
              controller.dlBackFile.value !=
                  null;
          break;

        case 'NID — Front':
          uploaded =
              controller.nidFrontFile.value !=
                  null;
          break;

        case 'NID — Back':
          uploaded =
              controller.nidBackFile.value !=
                  null;
          break;

        case 'Professional CV':
          uploaded =
              controller.cvFile.value != null;
          break;
      }

      return InkWell(
        onTap: () async {
          if (name == 'Professional CV') {
            await pickCV();
          } else {
            await pickImage(name);
          }
        },
        borderRadius:
            BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: uploaded
                ? maroon.withOpacity(0.04)
                : surface,
            borderRadius:
                BorderRadius.circular(14),
            border: Border.all(
              color: uploaded
                  ? maroon.withOpacity(0.4)
                  : line,
              width: uploaded ? 1.2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                          10),
                  border:
                      Border.all(color: line),
                ),
                alignment: Alignment.center,
                child: Icon(
                  uploaded
                      ? Icons
                          .description_rounded
                      : Icons
                          .upload_file_rounded,
                  color: maroon,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          GoogleFonts.inter(
                        fontSize: 13.5,
                        fontWeight:
                            FontWeight.w600,
                        color: ink,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      uploaded
                          ? 'Uploaded · Tap to replace'
                          : 'JPG, PNG or PDF',
                      style:
                          GoogleFonts.inter(
                        fontSize: 11,
                        color: sub,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: uploaded
                      ? maroon
                      : Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                          99),
                  border: Border.all(
                    color: uploaded
                        ? maroon
                        : line,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      uploaded
                          ? Icons
                              .check_rounded
                          : Icons.add_rounded,
                      size: 14,
                      color: uploaded
                          ? Colors.white
                          : ink,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      uploaded
                          ? 'Done'
                          : 'Add',
                      style:
                          GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight:
                            FontWeight.w700,
                        color: uploaded
                            ? Colors.white
                            : ink,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _agreementCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: maroon.withOpacity(0.05),
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color: maroon.withOpacity(0.15),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.shield_outlined,
            color: maroon,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: ink,
                  height: 1.5,
                ),
                children: const [
                  TextSpan(
                    text:
                        'By submitting, you agree to our ',
                  ),
                  TextSpan(
                    text: 'Driver Terms',
                    style: TextStyle(
                      fontWeight:
                          FontWeight.w700,
                      color: maroon,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' and confirm all documents are authentic.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomBar(BuildContext context) {
    return Obx(() {
      final ready = progress >= 1.0;

      return Container(
        padding: EdgeInsets.fromLTRB(
          20,
          14,
          20,
          MediaQuery.of(context)
                  .padding
                  .bottom +
              14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(top: BorderSide(color: line)),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Step Progress',
                  style:
                      GoogleFonts.inter(
                    fontSize: 11,
                    color: sub,
                  ),
                ),
                Text(
                  '$filled / 10 complete',
                  style:
                      GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w700,
                    color: ink,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: ready
                    ? () async {
                        await controller
                            .driverFullRegistrationFlow();
                      }
                    : null,
                icon: controller
                        .isLoadingRegister
                        .value
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.send_rounded,
                        size: 18,
                      ),
                label: Text(
                  controller
                          .isLoadingRegister
                          .value
                      ? 'Submitting...'
                      : ready
                          ? 'Submit Application'
                          : 'Continue',
                  style: GoogleFonts.inter(
                    fontWeight:
                        FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor: maroon,
                  disabledBackgroundColor:
                      maroon.withOpacity(0.4),
                  foregroundColor:
                      Colors.white,
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 22,
                  ),
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            14),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}