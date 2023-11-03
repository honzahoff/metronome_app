import 'package:flutter/material.dart';

import '../../resources/values/app_colors.dart';
import '../../resources/values/app_fonts.dart';

class TapMeWidget extends StatelessWidget {
  const TapMeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 160,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              border: Border.all(color: AppColors.primary400)),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80)),
            ),
            child: Text(
              "Tap me",
              style: AppFonts.bodyLarge,
            ),
          )),
    );
  }
}