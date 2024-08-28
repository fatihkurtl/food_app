import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final Color color;

  const CustomLoading({super.key, this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
