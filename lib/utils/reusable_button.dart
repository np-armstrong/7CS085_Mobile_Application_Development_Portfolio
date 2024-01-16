import 'package:flutter/material.dart';

/*To maintain a uniform button design across the app, I created a button
* class. It takes a string constructor to add text to the button and the
* voidcallback allows me to apply different functionality to
* each instance of a new button that I created.*/
class NewButton extends StatelessWidget {
  final String buttonName;
  VoidCallback onPressed;

  NewButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 20.0,
      onPressed: onPressed,
      color: Colors.deepOrange,
      child: Text(buttonName),
    );
  }
}
