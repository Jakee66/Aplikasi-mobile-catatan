import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'G',
            style: TextStyle(
              color: Color(0xFF4285F4),
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(width: 12),
          Text('Masuk dengan Google'),
        ],
      ),
    );
  }
}
