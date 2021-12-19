import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';

TypewriterAnimatedText animatedText({required String title}) {
  return TypewriterAnimatedText(
    title,
    textStyle: const TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
    ),
    speed: const Duration(milliseconds: 200),
  );
}
