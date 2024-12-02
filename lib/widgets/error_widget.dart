import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final String error;
  final String buttonText;
  final VoidCallback onRetry;

  const ErrorStateWidget({
    required this.error,
    required this.buttonText,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              error,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
