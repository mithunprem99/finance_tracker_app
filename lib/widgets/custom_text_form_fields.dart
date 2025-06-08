import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFields extends StatefulWidget {
  final TextEditingController textEditingController;
  String? hintText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  bool obscureText;
  CustomTextFormFields({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.obscureText,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
  });

  @override
  State<CustomTextFormFields> createState() => _CustomTextFormFieldsState();
}

class _CustomTextFormFieldsState extends State<CustomTextFormFields> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.displaySmall,
      controller: widget.textEditingController,
      obscureText: _obscureText,
     keyboardType: widget.keyboardType ??
      (widget.isPassword
          ? TextInputType.visiblePassword
          : widget.hintText?.toLowerCase().contains("phone") == true
              ? TextInputType.phone
              : TextInputType.emailAddress),
  inputFormatters: widget.hintText?.toLowerCase().contains("phone") == true
      ? [FilteringTextInputFormatter.digitsOnly]
      : null,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white),
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
      validator: widget.validator,
    );
  }
}
