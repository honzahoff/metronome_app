import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metronome_app/models/signature.dart';
import 'package:metronome_app/resources/values/app_colors.dart';
import 'package:metronome_app/resources/values/app_fonts.dart';
import 'package:metronome_app/resources/values/app_sizes.dart';

import '../widgets/drawer/drawer_menu_selection_button.dart';
import '../widgets/main_page/main_page_bottom_menu_widget.dart';
import '../widgets/main_page/main_page_display_widget.dart';
import '../widgets/main_page/main_page_tap_me_button.dart';
import '../widgets/main_page/main_page_tempo_slider.dart';
import '../widgets/main_page/main_page_ticker_widget.dart';

/// ### Main page of the app
///
///  It contains main componenents:
///
/// 1. [MainPageTickerWidget] for displaying current beat
/// 2. [MainPageDisplayWidget] for showing selected tempo
/// 3. [MainPageTempoSlider] for setting the tempo (you can also set the tempo using plus/minus buttons in the [MainPageDisplayWidget]),
/// 4. [MainPageTapMeButton] for manualy tapping the tempo
/// 5. [MainPageBottomMenuWidget] that works as a bottom navigation bar you can _start_ or _stop_ the metronome, or select different _sounds_ and _signatures_
///

final tempoProvider = StateProvider<int>((ref) {
  return 100;
});

class SignatureProvider extends StateNotifier<Signature> {
  SignatureProvider() : super(Signature(1, 2));

  void incrementFirstNumeral() {
    state = Signature(state.firstNumeral + 1, state.secondNumeral);
  }

  void incrementSecondNumeral() {
    state = Signature(state.firstNumeral, state.secondNumeral + 1);
  }
}

final signatureProvider =
    StateNotifierProvider<SignatureProvider, Signature>((ref) {
  return SignatureProvider();
});

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,

      // This is the MainPage AppBar.
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,

          //The leading - side menu icon that opens the Drawer.
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: AppColors.secondary500,
              ),
              iconSize: AppSizes.iconSize,
            );
          }),

          // User can add tempo, signature and sound to their favorites list via this button.
          actions: [
            IconButton(
              onPressed: () {},
              icon:
                  const Icon(Icons.star_border, color: AppColors.secondary500),
              iconSize: AppSizes.iconSize,
            )
          ]),

      // App drawer.
      drawer: Drawer(
        child: Container(
            decoration: const BoxDecoration(
                color: AppColors.secondary700,
                border:
                    Border(right: BorderSide(color: AppColors.secondary500))),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Column(
                  children: [
                    SizedBox(
                        height: 80,
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome back",
                              style: AppFonts.titleSmall,
                            ),
                            Text(
                              "John!",
                              style: AppFonts.displaySmall,
                            )
                          ],
                        )),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                // A column containing the list of links to menus.
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DrawerMenuSelectionButton(titleText: "Favorites"),
                    DrawerMenuSelectionButton(titleText: "Settings"),
                    DrawerMenuSelectionButton(titleText: "About")
                  ],
                ),
                const Spacer(flex: 6),
                Text(
                  "App version 1.0.0",
                  style: AppFonts.versionNumber,
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            )),
      ),

      // This is the body of the main screen.
      body: Container(
        // This is the background image that fills the main screen and extends behind the app bar.
        decoration: const BoxDecoration(
            /* gradient: RadialGradient(
        center: Alignment.bottomLeft,
        colors: [Color(0xFE291E4D), Color(0xFE10151D)],
        stops: [0, 1],
        radius: 1,
      ) */
            image: DecorationImage(
                image: AssetImage("assets/images/main_page_background.jpg"),
                fit: BoxFit.cover)),

        // Child collum containing TickerWidget, DisplayWidget, TempoSlider, TapMeButton and BottomMenuWidget.
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(flex: 2),

              // A widget that displays the current beat.
              MainPageTickerWidget(),
              SizedBox(height: 80),

              // A widget that shows the selected tempo and contains plus/minus controls.
              MainPageDisplayWidget(),
              Spacer(flex: 2),

              // A widget for setting the tempo.
              MainPageTempoSlider(),
              Spacer(flex: 2),

              // A button for manually tapping the tempo.
              MainPageTapMeButton(),

              // A widget with sound selection, signature selection and play/stop button.
              MainPageBottomMenuWidget(),
              SizedBox(
                height: 20,
              )
            ]),
      ),
    );
  }
}
