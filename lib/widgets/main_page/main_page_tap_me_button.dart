import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metronome_app/pages/main_page.dart';

import '../../models/metronome.dart';
import '../../resources/values/app_colors.dart';
import '../../resources/values/app_fonts.dart';

/// ### Tap me button
///
/// User can manually tap the tempo using this button.
///

class MainPageTapMeButton extends ConsumerWidget {
  const MainPageTapMeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Metronome metronome = ref.watch(metronomeControllerProvider);
    int tempo = metronome.tempo;
    int firstNumeral = metronome.signature.firstNumeral;
    int secondNumeral = metronome.signature.secondNumeral;
    String sound = metronome.sound;

    return Center(
      child: Container(
          width: 160,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              border: Border.all(color: AppColors.primary400)),
          child: ElevatedButton(
            onPressed: () {
              print(
                  "Tempo: $tempo, Signature: $firstNumeral / $secondNumeral Sound: $sound");
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
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
