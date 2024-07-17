import 'package:flutter/material.dart';
import 'package:run_it_app/core/extensions/context_extension.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colorScheme.primary,
          foregroundColor: context.colorScheme.onPrimary,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
