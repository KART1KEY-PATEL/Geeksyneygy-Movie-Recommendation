import 'package:flutter/material.dart';
import 'package:geeksynergymovie/utils/color.dart';

class CustomDivider extends StatelessWidget {
  CustomDivider({
    super.key,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return Container(
      height: height != 1 ? sH * height : 1,
      width: width != 1 ? sW * width : 1,
      color: AppColors.dividerColor,
    );
  }
}
