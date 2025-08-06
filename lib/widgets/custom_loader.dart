import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitThreeBounce(
            color: Theme.of(context).colorScheme.primary,
            size: 20.0,
          ),
          const SizedBox(width: 15),
          Text(
            'Thinking... please wait.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
