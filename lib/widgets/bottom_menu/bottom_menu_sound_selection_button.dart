import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:metronome_app/widgets/sound_selection/sound_selection_widget.dart';

import '../../resources/values/app_colors.dart';
import '../../resources/values/app_fonts.dart';
import 'bottom_menu_modal_sheet_wrapper.dart';

/// ### Sound selection button from the bottom menu
///
/// Used for selecting sound of a tick.
///
class BottomMenuSoundSelectionButton extends ConsumerWidget {
  const BottomMenuSoundSelectionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              border: Border.all(color: AppColors.secondary500)),
          child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: ((context) {
                      return const BottomMenuModalSheetWrapper(
                        height: 650,
                        titleText: "Select sound",
                        child: SoundSelectionWidget(),
                      );
                    }));
              },
              elevation: 0,
              backgroundColor: AppColors.secondary900,
              child: SvgPicture.asset("assets/icons/icon_note.svg",
                  height: 27,
                  width: 23,
                  colorFilter: const ColorFilter.mode(
                      AppColors.secondary200, BlendMode.srcIn))),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Text(
            "Sound",
            style: AppFonts.labelSmall,
          ),
        )
      ],
    );
  }
}
