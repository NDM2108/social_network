import 'package:flutter/material.dart';
import 'package:social_network/core/themes/app_colors.dart';
import 'package:social_network/core/themes/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool isPassword;
  final double? borderRadius;
  final bool? isError;
  final String? errorMessage;
  final double? height;

  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.textEditingController,
      this.onChanged,
      this.onSubmitted,
      this.isPassword = false,
      this.borderRadius,
      this.isError,
      this.errorMessage,
      this.height})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.height ?? 50,
          child: TextField(
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            controller: widget.textEditingController,
            obscureText: widget.isPassword ? hidePassword : false,
            decoration: InputDecoration(
                hintText: widget.hintText,
                filled: true,
                fillColor: AppColors.textFieldFill,
                contentPadding: const EdgeInsets.all(18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                  borderSide: const BorderSide(color: AppColors.textFieldBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          hidePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                          color: AppColors.greyTextColor,
                        ),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      )
                    : null),
          ),
        ),
        widget.isError == true
            ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  widget.errorMessage ?? '',
                  style: AppTextStyles.normalRed15,
                ),
              )
            : Container()
      ],
    );
  }
}
