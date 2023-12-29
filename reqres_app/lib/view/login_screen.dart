import 'package:flutter/material.dart';
import 'package:reqres_app/widgets/loadinglayer.dart';

import '../controller/auth_controller.dart';
import '../routes.dart';
import '../widgets/returnmessage.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  final AuthController controller;

  LoginScreen({required this.controller});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Hello!",
                      style:
                          TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Login to your account",
                      style: TextStyle(fontSize: 16),
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
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 0.5, // Spread radius
                              blurRadius: 12, // Blur radius
                              offset: const Offset(
                                  0, 12), // Offset in x and y directions
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
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 0.5, // Spread radius
                              blurRadius: 12, // Blur radius
                              offset: const Offset(
                                  0, 12), // Offset in x and y directions
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
                        await widget.controller.login(email, password);

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
                              'Login',
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
                    const Text("Don't you have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(
                              controller: AuthController(),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Create an account!",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
