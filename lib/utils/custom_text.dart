import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//
class CustomText extends StatelessWidget {
  final String data;
  final double? minFontSize;
  final double? fontSize;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Color? color;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final double? height; // <-- added

  const CustomText({
    Key? key,
    required this.data,
    this.fontSize = 12,
    this.minFontSize = 6,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight,
    this.fontFamily,
    this.decoration,
    this.textAlign,
    this.color,
    this.height, // <-- added
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      data,
      style: GoogleFonts.roboto(
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        color: color,
        height: height, // <-- applied here
      ),
      textAlign: textAlign,
      minFontSize: minFontSize!,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
