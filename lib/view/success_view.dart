import 'dart:async';

import 'package:employee_parking/helper/constant.dart';
import 'package:flutter/material.dart';

class success extends StatelessWidget {
  const success({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreen,
       body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                  Timer(Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
              },
              child: CircleAvatar(
                
                radius: 50.0,
                child: Icon(Icons.check, color: deepdarkblue),
                backgroundColor: darkblue,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Success!',
              style: TextStyle(fontSize: 20.0, color: deepdarkblue),
            ),
          ],
        ),
      ),
    );
  }
}
