import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.passwordController,
    required this.hint,
    required this.validator,
  });

  final TextEditingController passwordController;
  final String hint;
  final String? Function(String?)? validator;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.2),
        //     spreadRadius: 2,
        //     blurRadius: 8,
        //     offset: const Offset(0, 6),
        //   ),
        // ],
      ),
      child: TextFormField(
        controller: widget.passwordController,
        obscureText: obscurePassword,
        style: const TextStyle(
          color: primaryTextColor,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 239, 239, 239),
          hintText: widget.hint,
          hintStyle: const TextStyle(color: secondaryTextColor),
          prefixIcon: const Icon(
            Icons.lock,
            color: secondaryTextColor,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(
              16.0,
            )),
          ),
          suffixIcon: IconButton(
            icon:
                Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              // Toggle the password visibility
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          ),
        ),
        validator: widget.validator,
      ),
    );
  }
}
