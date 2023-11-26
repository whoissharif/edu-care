import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';

class AnimatedButton extends StatelessWidget {
  const AnimatedButton({
    super.key,
    this.isLoading = false,
    required this.text,
    required this.onTap,
  });

  final bool isLoading;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        curve: Curves.decelerate,
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: primaryColor,
          // gradient: LinearGradient(colors: [
          //   primaryColor.withOpacity(.4),
          //   primaryColor.withOpacity(.6),
          //   primaryColor.withOpacity(.8),
          //   primaryColor,
          //   primaryColor,
          // ]),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/images/right-arrow.png',
                    height: 25,
                    color: Colors.white,
                  ),
                ],
              ),
      ),
    );
  }
}
