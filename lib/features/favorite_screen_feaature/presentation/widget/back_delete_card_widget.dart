import 'package:flutter/material.dart';

class BackDeleteCardWidget extends StatelessWidget {
  const BackDeleteCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Colors.red,
      elevation: 8,
      child: Center(
        child: Text(
          'Deleting \ncharacter',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );  }
}
