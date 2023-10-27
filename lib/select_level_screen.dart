import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SelectLevelScreen extends StatefulWidget {
  const SelectLevelScreen({Key? key}) : super(key: key);

  @override
  State<SelectLevelScreen> createState() => _SelectLevelScreenState();
}

class _SelectLevelScreenState extends State<SelectLevelScreen> {

  /// rive controller and input values
  StateMachineController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff390A3B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Stack(
            children: [
              RiveAnimation.asset(
            fit: BoxFit.contain,
          "assets/select_level.riv",
          stateMachines: const ["State Machine 1"],
          onInit: (artboard) {
            controller = StateMachineController.fromArtboard(
              artboard,
              "State Machine 1",
            );
          },
          ),
              Align(
                alignment: Alignment.topCenter,
                  child: Text('Select Level', style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white
                  ),))
            ],
          ),
        ),
      ),
    );
  }
}
