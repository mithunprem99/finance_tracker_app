import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  void Function()? onPressed;
  final String subject;
  CustomButton({super.key, required this.onPressed, required this.subject});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        backgroundColor: Colors.deepOrangeAccent,
        maximumSize: Size(200, 600),
        minimumSize: Size(200, 40),
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.subject,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
      ),
    );
  }
}
