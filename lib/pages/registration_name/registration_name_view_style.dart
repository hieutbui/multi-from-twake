import 'package:fluffychat/resource/image_paths.dart';
import 'package:flutter/material.dart';

class RegistrationNameViewStyle {
  static BorderRadius nameTextFieldBorderRadius =
      const BorderRadius.all(Radius.circular(8));

  static BoxDecoration decoration = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF0E0F13),
        Color(0xFF191B26),
      ],
    ),
    image: DecorationImage(
      image: AssetImage(ImagePaths.imgRegistrationNameBackground),
      fit: BoxFit.cover,
    ),
  );
  static BoxDecoration helloContainerDecoration = BoxDecoration(
    color: const Color(0xFF374151).withAlpha(153),
    borderRadius: const BorderRadius.all(
      Radius.circular(20.0),
    ),
  );
}
