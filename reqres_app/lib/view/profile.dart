import 'package:flutter/material.dart';
import 'package:reqres_app/controller/auth_controller.dart';
import 'package:reqres_app/widgets/loadinglayer.dart';

import '../routes.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String userEmail = 'user@example.com'; // Replace with actual user email
  AuthController authcontoller = AuthController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.blue, // Adjust the color as needed
            padding: const EdgeInsets.all(32.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 8,
                ),
                const CircleAvatar(
                  radius: 50.0,
                  backgroundImage:
                      NetworkImage("https://reqres.in/img/faces/12-image.jpg"),
                ),
                const SizedBox(height: 16.0),
                Text(
                  userEmail,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Profile Details or Content Here',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await authcontoller.signOut();
                  await Future.delayed(Duration(seconds: 1));
                  Navigator.pushReplacementNamed(context, Routes.main);
                  setState(() {
                    isLoading = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: !isLoading ? Colors.red : Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: !isLoading
                    ? const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Sign Out',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: LoadingLayer(),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
