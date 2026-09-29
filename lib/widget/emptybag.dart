import 'package:flutter/material.dart';

class Emptybag extends StatelessWidget {
  const Emptybag({
    super.key,
    required this.imgpath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    this.onPressed,
  });

  final String imgpath;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Image.asset(imgpath, height: 220),
              const SizedBox(height: 20),
              Text(
                'Whoops!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              Text(title, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(subtitle, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: onPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
