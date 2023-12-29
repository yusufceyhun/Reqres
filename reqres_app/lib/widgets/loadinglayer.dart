import 'package:flutter/material.dart';

class LoadingLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.blue,
          ),
        ],
      ), // Loading indicator
    );
  }
}
