import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = Colors.blue,
  });

  final void Function()? onPressed;
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ButtonStyle(
      padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 25,
        ),
      ),
      backgroundColor: MaterialStatePropertyAll(backgroundColor),
      shadowColor: MaterialStatePropertyAll(backgroundColor),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      )),
    );

    final buttonText = Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: buttonText,
      ),
    );
  }
}
