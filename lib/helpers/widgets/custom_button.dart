import 'package:flutter/material.dart';
import 'package:social_network/core/themes/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;

  const CustomButton({Key? key, required this.onPressed, required this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return color ?? AppColors.primary; // Use the component's default.
            },
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
