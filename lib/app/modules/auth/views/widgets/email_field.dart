import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_colors.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

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
        controller: emailController,
        style: const TextStyle(
          color: primaryTextColor,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 239, 239, 239),
          hintText: 'Email',
          hintStyle: TextStyle(color: secondaryTextColor),
          prefixIcon: Icon(
            Icons.email,
            color: secondaryTextColor,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(
              16.0,
            )), // Adjust the radius as needed
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please provide an email address';
          } else if (!GetUtils.isEmail(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
      ),
    );
  }
}
