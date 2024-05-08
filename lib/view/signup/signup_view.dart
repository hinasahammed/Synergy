import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:synergy/res/components/custom_button.dart';
import 'package:synergy/res/components/custom_text_form_field.dart';
import 'package:synergy/viewmodel/controller/signup/signup_viewmodel.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signupViewmodel = Get.put(SignupViewmodel());
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://github.com/hinasahammed/sweatsquad/blob/main/assets/images/One%20Piece.jpeg?raw=true'),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * .52,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                  color: theme.colorScheme.background,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Join the Sweat Squad',
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: theme.colorScheme.onBackground,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Unlock Your Fitness Journey - Create Your Account',
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.onBackground,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(20),
                        CustomTextFormfield(
                          controller: signupViewmodel.userNameController.value,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter an username';
                            }
                            if (value.length < 3) {
                              return 'Username length is short';
                            }
                            return null;
                          },
                          fieldName: 'User name',
                        ),
                        const Gap(10),
                        CustomTextFormfield(
                          controller: signupViewmodel.emailController.value,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter email address';
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                .hasMatch(signupViewmodel
                                    .emailController.value.text)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                          fieldName: 'Email address',
                        ),
                        const Gap(10),
                        CustomTextFormfield(
                          controller: signupViewmodel.passwordController.value,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a password';
                            }
                            if (value.length < 6) {
                              return 'Your password is too short!';
                            }
                            if (!value.contains(RegExp(r'[A-Z]'))) {
                              return 'Uppercase must contain';
                            }
                            if (!value.contains(RegExp(r'[a-z]'))) {
                              return 'lowercase must contain';
                            }
                            if (!value.contains(RegExp(r'[0-9]'))) {
                              return 'digits must contain';
                            }
                            if (!value
                                .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                              return 'Special chareacter must contain';
                            }
                            return null;
                          },
                          fieldName: 'Password',
                        ),
                        const Gap(10),
                        CustomTextFormfield(
                          controller:
                              signupViewmodel.confirmPasswordController.value,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Confirm the password';
                            }
                            if (value !=
                                signupViewmodel.passwordController.value.text) {
                              return "Your password doesn't match";
                            }
                            return null;
                          },
                          fieldName: 'Confirm password',
                        ),
                        const Gap(10),
                        SizedBox(
                          width: size.width,
                          height: 50,
                          child: CustomButton(
                            btnTitle: 'Sign up',
                            isLoading: signupViewmodel.isLoading.value,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signupViewmodel.signup(context);
                              }
                            },
                          ),
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Already have an account?",
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: theme.colorScheme.onBackground,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Sign in",
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
