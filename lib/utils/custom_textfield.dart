import 'package:flutter/material.dart';
import 'package:geeksynergymovie/utils/color.dart';
import 'package:geeksynergymovie/utils/text_util.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validate = false,
    this.validatorText = "",
    required this.maxLines,
    this.title = "",
    this.hideText = false,
    this.obsureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.enabled = true,
  });
  String hintText;
  TextEditingController controller;
  bool validate;
  int maxLines;
  String title;
  bool obsureText;
  String validatorText;
  TextInputType keyboardType;
  Icon? prefixIcon;
  bool hideText;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
  bool enabled;
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    bool _passwordVisible = widget.obsureText;
    double sH = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title.length != 0
            ? txt(
                widget.title,
                size: sH * 0.02,
                color: AppColors.primaryTextColor,
              )
            : SizedBox(),
        SizedBox(
          height: sH * 0.008,
        ),
        TextField(
          enabled: widget.enabled,
          obscureText: widget.obsureText,
          controller: widget.controller,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon ?? null,
            hintText: widget.hintText,
            suffix: widget.hideText
                ? InkWell(
                    onTap: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        widget.obsureText = !widget.obsureText;
                      });
                    },
                    child: Container(
                      child: Icon(
                        widget.obsureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  )
                : null,
            alignLabelWithHint: true,
            errorText: widget.validate ? null : widget.validatorText,
          ),
        ),
      ],
    );
  }
}
