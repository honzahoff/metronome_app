import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:metronome_app/models/user.dart' as app_user;
import 'package:metronome_app/resources/values/app_colors.dart';
import 'package:metronome_app/resources/values/app_fonts.dart';
import 'package:metronome_app/services/user_service.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});
  static String get routeName => 'signup';
  static String get routeLocation => '/auth/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/main_page_background.jpg"),
                fit: BoxFit.cover)),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.go("/auth");
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
            height: 45,
          ),
          Center(
            child: Container(
              width: 150,
              height: 75,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'))),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "Create your account",
                  style: AppFonts.titleSmall,
                ),
                Text(
                  "Enter your email and password",
                  style: AppFonts.bodyLarge
                      .copyWith(color: AppColors.secondary500),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width > 480
                      ? 340
                      : MediaQuery.of(context).size.width * 0.85,
                  height: 62,
                  child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = RegExp(pattern.toString());
                        if (!regex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        } else {
                          return null;
                        }
                      },
                      cursorColor: AppColors.secondary300,
                      style: AppFonts.bodyMedium
                          .copyWith(color: AppColors.secondary300),
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
                          hintText: 'Your email address',
                          hintStyle: AppFonts.bodyMedium.copyWith(
                            color: AppColors.secondary500,
                          ))),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width > 480
                      ? 340
                      : MediaQuery.of(context).size.width * 0.85,
                  height: 62,
                  child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        } else if (value.length < 6) {
                          return "Passwords must be longer than 6 characters";
                        } else {
                          return null;
                        }
                      },
                      cursorColor: AppColors.secondary300,
                      obscureText: true,
                      style: AppFonts.bodyMedium
                          .copyWith(color: AppColors.secondary300),
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
                          hintText: 'Your password',
                          hintStyle: AppFonts.bodyMedium
                              .copyWith(color: AppColors.secondary500))),
                ),
                Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width > 480
                      ? 340
                      : MediaQuery.of(context).size.width * 0.85,
                  margin: const EdgeInsets.only(top: 15),

                  // It has a decoration of a rectangle with rounded corners. The radius is 10px.
                  decoration: BoxDecoration(
                    color: AppColors.primary400,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  // The ElevatedButton is a child of the Container. It makes the button clickable.
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);

                        final user = FirebaseAuth.instance.currentUser;
                        const u = app_user.User(
                            id: null,
                            favorites: null,
                            settings: null,
                            username: "asdasd",
                            email: "asdasd");

                        createUser(u);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    // Title of the button.
                    child: Text(
                      "Continue",
                      style: AppFonts.bodyLarge
                          .copyWith(color: AppColors.secondary900),
                    ),

                    // Icon - always chevron_right since it is a navigation button.
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    context.go("/auth/login");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: AppFonts.bodyMedium
                            .copyWith(color: AppColors.secondary500),
                      ),
                      Text(
                        "Log in",
                        style: AppFonts.bodyMedium
                            .copyWith(color: AppColors.primary400),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const Spacer(
            flex: 2,
          )
        ]),
      ),
    );
  }
}
