import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.foregroundColor = Colors.blue,
    this.borderColor = Colors.blue,
    this.icon,
  });

  final void Function()? onPressed;
  final String text;
  final Color foregroundColor;
  final Color borderColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ButtonStyle(
      padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 25,
        ),
      ),
      backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
      shadowColor: const MaterialStatePropertyAll(Colors.transparent),
      side: MaterialStatePropertyAll(
        BorderSide(color: borderColor, width: 1.5, style: BorderStyle.solid),
      ),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      )),
    );

    final buttonText = Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: foregroundColor,
      ),
    );

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: icon == null
            ? buttonText
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon!,
                  const SizedBox(width: 15),
                  buttonText,
                ],
              ),
      ),
    );
  }
}
