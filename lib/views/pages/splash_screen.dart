import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => SplashScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Cooking nuggets for you :-)',
              style: TextStyle(fontSize: 22.0),
            ),
            SizedBox(height: 32.0),
            LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
