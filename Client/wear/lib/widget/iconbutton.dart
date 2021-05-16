import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  final IconData icon;

  const IconButtonWidget({
    Key key,
    this.buttonText,
    this.buttonColor,
    this.textColor = Colors.white,
    this.onPressed,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: buttonColor,
      shape: StadiumBorder(),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: textColor,
            ),
            buttonText != null ? SizedBox(width: 10) : Container(),
            buttonText != null
                ? Text(
                    buttonText,
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: textColor),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
