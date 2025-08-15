import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final Function()? onRetry;

  const ErrorView({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          if (onRetry != null)
            ElevatedButton(
                onPressed: () {
                  onRetry!();
                },
                child: Text("Retry"))
        ],
      ),
    );
  }
}
