import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metronome_app/widgets/signature_selection/signature_selection_widget.dart';

import '../../entities/metronome.dart';
import '../../resources/values/app_colors.dart';
import '../../resources/values/app_fonts.dart';
import '../../state/metronome_controller.dart';
import 'bottom_menu_modal_sheet_wrapper.dart';

/// ### Signature selection button
///
/// Used for setting the signature. Opens the [SoundSelectionWidget] where user can set his own tempo preference.
///
class BottomMenuSignatureSelectionButton extends ConsumerWidget {
  const BottomMenuSignatureSelectionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Metronome metronome = ref.watch(metronomeControllerProvider);

    final String firstNumeral = metronome.signature.firstNumeral.toString();
    final String secondNumeral = metronome.signature.secondNumeral.toString();

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
                        height: 430,
                        titleText: "Select signature",
                        child: SignatureSelectionWidget());
                  }));
            },
            elevation: 0,
            backgroundColor: AppColors.secondary900,
            child: Text(
              "$firstNumeral/$secondNumeral",
              style: AppFonts.sigIcon,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Text(
            "Signature",
            style: AppFonts.labelSmall,
          ),
        )
      ],
    );
  }
}
