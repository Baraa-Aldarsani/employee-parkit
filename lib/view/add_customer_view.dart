import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/customer/customer_controller.dart';
import '../helper/clipper.dart';
import '../helper/constant.dart';
import 'all_customer_view.dart';

class AddCustomerView extends StatelessWidget {
  AddCustomerView({Key? key}) : super(key: key);
  final _controller = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            SizedBox(
                height: 300,
                child: ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    color: darkblue,
                    height: 200,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Text(
                'ADD CUSTOMER',
                style: TextStyle(
                    color: deepdarkblue,
                    fontWeight: FontWeight.bold,
                    fontSize: 60),
              ),
            ),
          ]),
          const SizedBox(height: 45),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller.nameCustomer,
              decoration: InputDecoration(
                fillColor: lightgreen,
                hintText: 'Customer Name',
                prefixIcon: Icon(
                  Icons.person,
                  color: deepdarkblue,
                ),
                hintStyle: TextStyle(color: deepdarkblue),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: deepdarkblue),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller.numberCustomer,
              decoration: InputDecoration(
                fillColor: lightgreen,
                hintText: 'Car Number',
                prefixIcon: Icon(
                  Icons.car_repair,
                  color: deepdarkblue,
                ),
                hintStyle: TextStyle(color: deepdarkblue),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: deepdarkblue),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 35),
          const SizedBox(height: 35),
          Center(
            child: MaterialButton(
              onPressed: () {
                _controller.addCustomer();
              },
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              color: deepdarkblue,
              minWidth: 250,
              height: 50,
              child: Text('ADD',
                  style: TextStyle(
                      color: grey, fontFamily: AutofillHints.familyName,fontSize: 20
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}
