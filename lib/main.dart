import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps_flutter/mainwrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: GoogleFonts.ubuntu().fontFamily),
      home: const MainWrapper(),
    );
  }
}
