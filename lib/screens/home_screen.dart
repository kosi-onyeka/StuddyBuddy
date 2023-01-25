import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StuddyBestie'),
        backgroundColor: Color.fromARGB(255, 45, 115, 121),
      ),
    );
  }
}
