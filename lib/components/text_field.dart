import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const Textfield({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    //getting heigth and width
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: SizedBox(
        height: screenHeight * 0.07,
        child: TextField(
          controller: controller,
          cursorColor: Theme.of(context).colorScheme.primary,
          onChanged: onChanged,
          style: TextStyle(color: Theme.of(context).colorScheme.primary, fontFamily: "Poppins"),
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.secondary,
            contentPadding: const EdgeInsets.all(8),
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.primary,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
