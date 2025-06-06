import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  double? height;
  Color? color;
  double? thickness;
   CustomDivider({super.key,this.height,this.color,this.thickness});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(
        height: height,
        color: color,
        thickness: thickness,
      ),
    );
  }
}