import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              IconlyBold.profile,
              size: 100,
            ),
            const Text(
              "Profile",
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
