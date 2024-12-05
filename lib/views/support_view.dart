import 'package:flutter/material.dart';
import 'package:maps_flutter/components/bottom_field.dart';
import 'package:maps_flutter/components/message_blocks.dart';
import 'package:maps_flutter/models/demo_text.dart';

class SupportView extends StatefulWidget {
  const SupportView({super.key});
  @override
  State<SupportView> createState() => _SupportState();
}

class _SupportState extends State<SupportView> {
  final ScrollController _scrollController = ScrollController();
  //demo text
  final List<DemoText> demoTexts = [
    DemoText(text: "Hello!", user: true),
    DemoText(text: "Hello! How may I assist you today?", user: false),
    DemoText(text: "I'm having problems with the app.", user: true),
    DemoText(
        text:
            "I am sorry to hear that. What exactly is the issue so I can provide assistance?",
        user: false),
    DemoText(text: "I can't log in.", user: true),
    DemoText(text: "And I can't create a new account.", user: true),
    DemoText(text: "I'm so sorry to hear that.", user: false),
    DemoText(
        text: "You may need to reset your account's password and try again",
        user: false),
    DemoText(text: "Okay", user: true),
    DemoText(text: "Please let us know if the issue persists.", user: false),
    DemoText(text: "Okay. Doing that now.", user: true),
    DemoText(
        text: "I am on standby if you need further assistance.", user: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: demoTexts.length,
              itemBuilder: (context, index) {
                return MessageBlocks(item: demoTexts[index]);
              },
            ),
          ),
          const BottomField(),
        ],
      ),
    );
  }
}
