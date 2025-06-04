import 'package:flutter/material.dart';

class CustomTextFormFields extends StatefulWidget {
  final TextEditingController textEditingController;
  String? hintText;
  final bool isPassword;

  bool obscureText;
  CustomTextFormFields({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.obscureText,
    this.isPassword = false,
  });

  @override
  State<CustomTextFormFields> createState() => _CustomTextFormFieldsState();
}

class _CustomTextFormFieldsState extends State<CustomTextFormFields> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword; // Only obscure if it's a password field
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.displaySmall,
      controller: widget.textEditingController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
      ),
      keyboardType: widget.isPassword
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.isPassword ? 'Enter password' : 'Enter email';
        }
        if (!widget.isPassword && !value.contains('@')) {
          return 'Enter a valid email';
        }
        return null;
      },
    );
  }
}
