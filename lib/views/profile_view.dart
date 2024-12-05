import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: (Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text(
                "User",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                'User@email.com',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://wallpapers.com/images/hd/profile-picture-background-xyyvpmbyouhknwrk.jpg"))),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://murrayglass.com/wp-content/uploads/2020/10/avatar-2048x2048.jpeg"),
              ),
            ),
            Form(
                child: Column(
              children: [
                const SizedBox(height: 25),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text("First Name"),
                      prefixIcon: Icon(IconlyBold.profile)),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text("Last Name"),
                      prefixIcon: Icon(IconlyBold.profile)),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text("Email"),
                      prefixIcon: Icon(IconlyBold.message)),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    onPressed: () {},
                    child: const Text(
                      "Save Changes",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ))
          ],
        )),
      ),
    ));
  }
}
