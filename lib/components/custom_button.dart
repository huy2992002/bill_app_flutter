import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final double height;
  final Color color;
  final Color borderColor;
  final double radius;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textColor = Colors.white,
    this.height = 40,
    this.color = Colors.blue,
    this.borderColor = Colors.yellow,
    this.radius = 14,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Colors.blue,
            offset: Offset(0.0, 3.3),
            blurRadius: 7,
          ),
        ],
        ),

        child: Text(text,style: TextStyle(color: textColor),),
      ),
    );
  }
}
