import 'package:flutter/material.dart';

class EmptyBag extends StatelessWidget {
  const EmptyBag({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
  });

  final String imagePath;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imagePath, height: 220),
              const SizedBox(height: 18),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 22),
              FilledButton(
                onPressed: onPressed,
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
