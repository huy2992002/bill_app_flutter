import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final double? width;
  final double height;
  final Color borderColor;
  final double borderRadius;
  final bool obscureText;
  final IconData? icon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.width,
    this.height = 50,
    this.borderColor = Colors.blue,
    this.borderRadius = 14,
    this.obscureText = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            color: Colors.blue,
            offset: Offset(0.0, 3.3),
            blurRadius: 7,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          prefixIcon: icon == null ? null : Icon(icon, color: Colors.blue),
        ),
      ),
    );
  }
}
