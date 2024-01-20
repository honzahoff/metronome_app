import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../resources/values/app_colors.dart';
import '../../resources/values/app_fonts.dart';
import '../../state/auth_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});
  static String get routeName => 'settings';
  static String get routeLocation => '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(authProvider.select(
      (value) => value.valueOrNull?.email,
    ));

    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/main_page_background.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.go("/");
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.secondary200,
                        size: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Home",
                      style: AppFonts.titleSmall,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Settings",
                    style: AppFonts.titleLarge,
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "ACCOUNT",
                    style: AppFonts.labelLarge
                        .copyWith(color: AppColors.secondary500),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                decoration: const BoxDecoration(
                    color: AppColors.secondary700,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ListTile(
                  iconColor: AppColors.secondary200,
                  textColor: AppColors.secondary200,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  leading: const Icon(FontAwesomeIcons.solidEnvelope),
                  title: Text(
                    "Email",
                    style: AppFonts.bodyLarge,
                  ),
                  tileColor: AppColors.secondary700,
                  subtitle: Text(
                    name ?? "Not logged in",
                    style: AppFonts.bodyMedium.copyWith(
                        color: AppColors.secondary200.withOpacity(0.6)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                decoration: const BoxDecoration(
                    color: AppColors.secondary700,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ListTile(
                  iconColor: AppColors.secondary200,
                  textColor: AppColors.secondary200,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  leading: const Icon(FontAwesomeIcons.solidUser),
                  title: Text(
                    "Username",
                    style: AppFonts.bodyLarge,
                  ),
                  tileColor: AppColors.secondary700,
                  subtitle: Text(
                    name ?? "Not logged in",
                    style: AppFonts.bodyMedium.copyWith(
                        color: AppColors.secondary200.withOpacity(0.6)),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.chevronRight,
                      size: 15,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "APP",
                    style: AppFonts.labelLarge
                        .copyWith(color: AppColors.secondary500),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                decoration: const BoxDecoration(
                    color: AppColors.secondary700,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ListTile(
                  iconColor: AppColors.secondary200,
                  textColor: AppColors.secondary200,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  leading: const Icon(FontAwesomeIcons.mobile),
                  title: Text(
                    "Haptic feedback",
                    style: AppFonts.bodyLarge,
                  ),
                  tileColor: AppColors.secondary700,
                  trailing: Switch(
                    onChanged: (value) {},
                    value: true,
                    activeColor: AppColors.primary400,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                decoration: const BoxDecoration(
                    color: AppColors.secondary700,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ListTile(
                  iconColor: AppColors.primary400,
                  textColor: AppColors.primary400,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  leading: const Icon(FontAwesomeIcons.arrowRightFromBracket),
                  title: Text(
                    "Sign out",
                    style: AppFonts.bodyLarge
                        .copyWith(color: AppColors.primary400),
                  ),
                  tileColor: AppColors.secondary700,
                  trailing: IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.chevronRight,
                      size: 15,
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
