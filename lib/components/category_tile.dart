import 'package:expense_tracker/pages/element_category.dart';
import 'package:flutter/material.dart';

class CategorieTile extends StatelessWidget {
  final String title;

  const CategorieTile({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.tertiary,
        title: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ElementPage(category: title)));
        },
      ),
    );
  }
}
