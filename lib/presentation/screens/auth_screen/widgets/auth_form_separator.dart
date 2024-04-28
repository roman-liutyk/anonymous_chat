import 'package:flutter/material.dart';

class AuthFormSeparator extends StatelessWidget {
  const AuthFormSeparator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[400],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'or',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[400],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}
