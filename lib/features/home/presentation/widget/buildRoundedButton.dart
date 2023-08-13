import 'package:flutter/material.dart';

Widget buildRoundedButton(IconData icon, String text, Color bgColor) {
  return OutlinedButton(
    onPressed: () {
      // Handle button press
    },
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      side: const BorderSide(
        color: Color(0xFF737373),
      ),
      backgroundColor: bgColor,
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.black),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(color: Colors.black)),
      ],
    ),
  );
}
