import 'package:employee_parking/helper/constant.dart';
import 'package:flutter/material.dart';

class Customer_view extends StatelessWidget {
  const Customer_view({super.key, required Type customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: lightgreen,),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          color: lightgreen,
        
      
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 40,),
                Row(
                  children: [
                    Text('CUSTOMER NAME : ',
                    style: TextStyle(
                      fontSize: 25,
                      color: deepdarkblue,
                    ),
                    ),
                    Text('ahmad',style: TextStyle(
                       fontSize: 15,
                      color: deepdarkblue,
                    ),
                    ),
                  ],
                ),

                SizedBox(height: 40,),
                Row(
                  children: [
                    Text('CAR NUMBER :',
                    style: TextStyle(
                      fontSize: 25,
                      color: deepdarkblue,
                    ),
                    ),
                    Text('409876',style: TextStyle(
                       fontSize: 15,
                      color: deepdarkblue,
                    ),)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}