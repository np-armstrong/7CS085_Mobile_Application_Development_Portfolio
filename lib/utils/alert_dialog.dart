import 'package:flutter/material.dart';
import 'package:wlv_blog/utils/reusable_button.dart';

class PopUpAlert extends StatelessWidget {
  final String alertText;

  const PopUpAlert({super.key, required this.alertText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        alertText,
        textAlign: TextAlign.center,
      ),
      content: Container(
        color: Colors.grey[800],
        height: 100,
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NewButton(
              buttonName: 'Ok',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
