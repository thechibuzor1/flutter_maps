import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              IconlyBold.shield_done,
              size: 100,
            ),
            const Text(
              "Home",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text("home screen")),
            TextButton(onPressed: () {}, child: const Text("Go to home"))
          ],
        ),
      ),
    );
  }
}
