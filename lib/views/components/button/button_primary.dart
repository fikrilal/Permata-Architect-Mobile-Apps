import 'package:flutter/material.dart';

Widget primaryButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF419681),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      minimumSize: Size(double.infinity, 0),
      padding: const EdgeInsets.symmetric(
          vertical: 16),
      elevation: 0,
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontFamily: 'Satoshi',
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}