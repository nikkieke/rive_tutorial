import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu_rounded,
                  size: 35,
                ),
                color: Colors.black,
                style: IconButton.styleFrom(shape: const CircleBorder()),
              ),
              const CircleAvatar(backgroundColor: Colors.purple,)
            ],
          ),
          const SizedBox(height: 20),
          const Text("Hello Nikki,",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600))
        ]),
      ),
    ));
  }
}
