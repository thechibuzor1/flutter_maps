import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              IconlyBold.time_circle,
              size: 100,
            ),
            const Text(
              "History",
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
