import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.width = 120,
    this.height = 50,
    this.fit = BoxFit.contain,
  });

  final double width;
  final double height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final Usergetxcontroller controller =
        Get.find<Usergetxcontroller>();

    return Obx(
      () {
        final bool darkMode =
            controller.IsDarkMode.value;

        return Image.asset(
          darkMode
              ? 'assets/images/logo_dark.png'
              : 'assets/images/logo_light.png',

          width: width,
          height: height,

          fit: fit,

          errorBuilder:
              (
                context,
                error,
                stackTrace,
              ) {
            return Icon(
              Icons.directions_car_rounded,
              size: height,
              color:
                  darkMode
                      ? Colors.white
                      : const Color(
                          0xFF800000,
                        ),
            );
          },
        );
      },
    );
  }
}