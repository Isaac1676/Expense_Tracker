import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyListile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final void Function(BuildContext)? onDelPressed;

  const MyListile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.onDelPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDelPressed,
              backgroundColor: Colors.red,
              icon: Icons.delete,
            ),
          ],
        ),
        child: ListTile(
          tileColor: Theme.of(context).colorScheme.tertiary,
          title: Text(
            title,
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600),
          ),
          trailing: Text(amount,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
