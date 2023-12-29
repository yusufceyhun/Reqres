import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';
import 'package:lottie/lottie.dart';

import '../routes.dart';
import '../widgets/loadinglayer.dart';
import '../widgets/returnmessage.dart';

class RegisterScreen extends StatefulWidget {
  final AuthController controller;

  RegisterScreen({required this.controller});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.network(
                      "https://lottie.host/3251073d-c34a-4b4b-85ce-130cea3f7e72/vwcW1iN7p2.json",
                      height: 150, // Adjust the height of the animation
                      width: 150, // Adjust the width of the animation
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                    const Text(
                      "Create a new account!",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 12,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 12,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    toggleLoading();

                    String email = emailController.text;
                    String password = passwordController.text;
                    ReturnMessage message =
                        await widget.controller.register(email, password);

                    if (message.result) {
                      await Future.delayed(Duration(seconds: 1));
                      showReturnMessage(message);
                      Navigator.pushReplacementNamed(context, Routes.main);
                    } else {
                      showReturnMessage(message);
                    }
                    toggleLoading();
                  },
                  child: !isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              child: const Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      : LoadingLayer(),
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Go back to the login screen
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
