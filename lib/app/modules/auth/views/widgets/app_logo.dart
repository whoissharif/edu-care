import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'EduCare',
      style: GoogleFonts.pacifico(
          textStyle: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w900,
        color: primaryColor,
      )),
    );
  }
}
