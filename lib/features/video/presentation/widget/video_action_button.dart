import 'package:flutter/material.dart';

class ActionButtom extends StatelessWidget {
  const ActionButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.cyan),
            onPressed: () {
              // Handle share button press
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.cyan),
            onPressed: () {
              // Handle like button press
            },
          ),
        ],
      ),
    );
  }
}
