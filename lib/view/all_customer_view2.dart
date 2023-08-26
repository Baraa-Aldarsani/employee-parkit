import 'package:employee_parking/helper/constant.dart';
import 'package:employee_parking/view/success_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class customer {
  final String name;
  final String number;
  // Icon selectedIcon;

  customer({
    required this.name,
    required this.number,
    // required Icon selectedIcon,
  });
}



class AllCustomerView2 extends StatelessWidget {
  final names = ['ahmad', 'samer', 'saa','gt','hkghj','hjftyf','hfdf','hghtdrg','gchcf','ahmad', 'samer', 'samer', 'samer', 'samer'];
  final numbers = ['2001', '300', '4875','66', '4875','66', '4875','66', '4875','66', '4875','66','66', '4875','66','66', '4875','66','66', '4875','66'];
  
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: lightgreen,
      //leading: Icon(Icons.arrow_back,color:deepdarkblue,),
      ),
      
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap:(){
             Get.to(success());
               //Get.to(Customer_view(customer: customer));
            },
            child: Card(
              borderOnForeground: debugDisableShadows,
              child: ListTile(
                title: Text(names[index],style: TextStyle(color: darkblue,fontWeight: FontWeight.bold,fontSize: 25
                ),),
                subtitle: Text(numbers[index],style: TextStyle(color: deepdarkblue,fontSize: 20),),
                leading: Icon(Icons.car_repair_outlined,color: deepdarkblue,size: 30,),
              ),
              // dividerColor: Colors.green
              //color:lightgreen ,
            ),
          );
        },
      ),
    );
  }
}