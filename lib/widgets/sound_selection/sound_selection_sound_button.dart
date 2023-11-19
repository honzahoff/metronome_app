import 'package:flutter/material.dart';
import 'package:metronome_app/resources/values/app_fonts.dart';

import '../../resources/values/app_colors.dart';

// I have to make this differently
class SoundSelectionSoundButton extends StatelessWidget {
  final String name;
  final bool selected;
  const SoundSelectionSoundButton(
      {super.key, this.name = "", this.selected = false});

  @override
  Widget build(BuildContext context) {
    if (!selected) {
      return Container(
        width: 340,
        height: 56,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: AppColors.secondary900,
            border: Border.all(color: AppColors.secondary500),
            borderRadius: BorderRadius.circular(10)),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              textAlign: TextAlign.left,
              style: AppFonts.bodyLarge,
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: 340,
        height: 56,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: AppColors.primary400,
            borderRadius: BorderRadius.circular(10)),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Piano",
              textAlign: TextAlign.left,
              style: AppFonts.bodyLarge,
            ),
            const Icon(Icons.check)
          ]),
        ),
      );
    }
  }
}