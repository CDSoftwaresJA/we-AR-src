import 'package:flutter/material.dart';
import 'package:wear/utils/colors.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              height: 300,
            ),
            Container(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(AppColors.color),
              ),
              height: 20,
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}
