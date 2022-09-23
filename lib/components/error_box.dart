import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  const ErrorBox({Key? key, this.message}) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message == null) {
      return Container();
    } else {
      return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(4),
        color: Colors.red,
        child: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white70,
              size: 40,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                'Oops! $message. Por favor, tente novamente',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
            )
          ],
        ),
      );
    }

    return Container();
  }
}
