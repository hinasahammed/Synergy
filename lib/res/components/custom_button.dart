// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String btnTitle;
  final bool isLoading;
  const CustomButton({
    super.key,
    this.onPressed,
    required this.btnTitle,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
      ),
      onPressed: onPressed,
      child: isLoading
          ? CircularProgressIndicator(
              color: theme.colorScheme.onPrimary,
            )
          : Text(
              btnTitle,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }
}
