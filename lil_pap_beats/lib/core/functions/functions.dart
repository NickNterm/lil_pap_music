import 'package:flutter/material.dart';
import 'package:lil_pap_beats/constant/colors.dart';
import 'package:palette_generator/palette_generator.dart';

void showSnackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

Future<Color> getImagePalette(ImageProvider imageProvider) async {
  final PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(imageProvider);
  if (paletteGenerator.dominantColor == null) return kPrimaryColor;
  return paletteGenerator.paletteColors.first.color;
}
