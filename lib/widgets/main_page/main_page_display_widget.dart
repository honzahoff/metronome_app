import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:metronome_app/resources/helpers/app_tempo_transcription.dart';

import '../../entities/metronome.dart';
import '../../resources/values/app_colors.dart';
import '../../resources/values/app_fonts.dart';
import '../../state/metronome_controller.dart';

/// ### Display widget
///
/// It displays current tempo to user and contains information about latin tempo, bpm label and plus/minus buttons.
/// With plus/minus buttons user can adjust the tempo by 1/-1.
///
///
class MainPageDisplayWidget extends ConsumerWidget {
  const MainPageDisplayWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Metronome metronome = ref.watch(metronomeControllerProvider);
    int tempo = metronome.tempo;

    final String italianTranscription =
        TempoTranscription().getTranscription(tempo);

    return Center(
      child: SizedBox(
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Minus button to decrease the tempo by 1.
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/icon_minus.svg",
                height: 20,
                width: 20,
                colorFilter: const ColorFilter.mode(
                    AppColors.secondary500, BlendMode.srcIn),
              ),
              color: AppColors.secondary500,
              iconSize: 40,
              onPressed: () {
                ref.read(metronomeControllerProvider.notifier).decreaseTempo();
                ref.read(metronomeControllerProvider.notifier).resync();
              },
            ),

            // This collumn contains main information - latin text, tempo and bpm label
            Column(children: [
              Text(
                italianTranscription,
                style: AppFonts.titleSmall,
              ),
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: Text(
                  "$tempo",
                  style: AppFonts.displayLarge,
                ),
              ),
              Text(
                "BPM",
                style: AppFonts.bodyLarge,
              )
            ]),

            // Plus button to increase the tempo by 1.
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/icon_plus.svg",
                height: 20,
                width: 20,
                colorFilter: const ColorFilter.mode(
                    AppColors.secondary500, BlendMode.srcIn),
              ),
              color: AppColors.secondary500,
              iconSize: 40,
              onPressed: () {
                ref.read(metronomeControllerProvider.notifier).increaseTempo();
                ref.read(metronomeControllerProvider.notifier).resync();
              },
            ),
          ],
        ),
      ),
    );
  }
}
