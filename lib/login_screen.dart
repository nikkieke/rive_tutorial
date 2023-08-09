import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ///Login details
  String emailCred = "nikki@gmail.com";
  String passwordCred = "123456";

  /// input form controller
  FocusNode emailFocusNode = FocusNode();
  TextEditingController emailCtr = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  TextEditingController passwordCtr = TextEditingController();


  /// rive controller and input values
  StateMachineController? controller;

  SMIInput<bool>? check;
  SMIInput<double>? look;
  SMIInput<bool>? success;
  SMIInput<bool>? fail;


  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    super.dispose();
  }

  void emailFocus() {
    check?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    check?.change(passwordFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffB581EB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              children: [
            const SizedBox(
              height: 80,
            ),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.topLeft,
                      child: Text("Welcome Back!",
                        style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),)),
                ),
                const SizedBox(
                  height: 50,
                ),
            SizedBox(
              height: 250,
              width: 250,
              child: RiveAnimation.asset(
                "assets/login_screen.riv",
                fit: BoxFit.fitHeight,
                stateMachines: const ["Login State Machine"],
                onInit: (artboard) {
                  controller = StateMachineController.fromArtboard(
                    artboard,
                    "Login State Machine",
                  );
                  if (controller == null) return;
                  artboard.addController(controller!);
                  check = controller?.findInput("check");
                  look = controller?.findInput("look");
                  success = controller?.findInput("success");
                  fail = controller?.findInput("fail");
                },
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: isError? Colors.red: Colors.transparent)
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextField(
                        focusNode: emailFocusNode,
                        controller: emailCtr,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                        onChanged: (value) {
                          look?.change(value.length.toDouble());
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: isError? Colors.red: Colors.transparent)
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextField(
                        focusNode: passwordFocusNode,
                        controller: passwordCtr,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                        obscureText: true,
                        style: Theme.of(context).textTheme.bodyMedium,
                        onChanged: (value) {
                          look?.change(value.length.toDouble());
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 64,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffB581EB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () async{
                            emailFocusNode.unfocus();
                            passwordFocusNode.unfocus();
                            login();
                          },
                          child: isLoading?
                              const CircularProgressIndicator(color: Colors.white,):
                              const Text("Login", style: TextStyle(color: Colors.white, fontSize: 16),),

                        )),
                  ],
                ))
          ]),
        ),
      ),
    );

  }
  void login()async{
    final email = emailCtr.text;
    final password = passwordCtr.text;

    setState(() {
      isLoading = true;
    });
    await Future.delayed(
      const Duration(milliseconds: 2000),
    );

    if (email == emailCred && password == passwordCred) {
      success?.change(true);
      setState(() {
        isError = false;
      });
      if(context.mounted){
        await Future.delayed(
            const Duration(seconds: 2),(){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>const HomeScreen()));
        });
      }

    } else {
      setState(() {
        isError = true;
      });
      fail?.change(true);
    }
    setState(() {
      isLoading = false;
    });

  }
}

