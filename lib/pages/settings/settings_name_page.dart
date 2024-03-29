import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../resources/values/app_colors.dart';
import '../../resources/values/app_fonts.dart';
import '../../state/providers/user_provider.dart.dart';

/// ### Settings name page
///
/// Page where user can edit their name
///
///
class SettingsNamePage extends ConsumerWidget {
  const SettingsNamePage({super.key});
  static String get routeName => 'username-edit';
  static String get routeLocation => '/settings/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Global form key
    final formKey = GlobalKey<FormState>();

    // Controller attached to text field in form
    final nameController = TextEditingController();

    // RiverPod
    final user = ref.watch(userProvider);
    final userNotifier = ref.watch(userProvider.notifier);

    // Updates user's name
    Future<void> updateName() async {
      if (formKey.currentState!.validate()) {
        await userNotifier.updateName(nameController.text);
      }
    }

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
                        context.go("/settings");
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
                      "Settings",
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
                    "Change your name",
                    style: AppFonts.titleLarge,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ListTile(
                  textColor: AppColors.secondary200,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  title: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your name";
                        } else if (value.length > 20) {
                          return "Names must not be longer than 20 characters";
                        } else {
                          return null;
                        }
                      },
                      cursorColor: AppColors.secondary300,
                      style: AppFonts.bodyLarge
                          .copyWith(color: AppColors.secondary200),
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: AppColors.secondary500, width: 1)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: AppColors.secondary500, width: 1)),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: AppColors.secondary500, width: 1)),
                          hintText: user?.name,
                          hintStyle: AppFonts.bodyLarge.copyWith(
                              color: AppColors.secondary200.withOpacity(0.5))),
                      onEditingComplete: () async {
                        await updateName();
                      },
                    ),
                  ),
                  tileColor: AppColors.secondary700,
                ),
              ),
            ],
          )),
    );
  }
}
