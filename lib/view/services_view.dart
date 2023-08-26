import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_parking/helper/constant.dart';
import 'package:employee_parking/model/customer_model.dart';
import 'package:employee_parking/view/all_customer_view.dart';
import 'package:employee_parking/view/all_customer_view2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

import '../controller/services/services_controller.dart';

class Services extends StatelessWidget {
  Services({super.key,required this.customerModel});
  final CustomerModel customerModel;
  final ServicesController _controller = Get.put(ServicesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<void>(
        future: _controller.servicesGarageModel(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return const Text("");
          }else{
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
              ),
              itemCount: _controller.servicesGarage.length,
              itemBuilder: (context, index) {
                var service = _controller.servicesGarage[index];
                return GestureDetector(
                  onTap: (){
                  },
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(service.name,style: TextStyle(fontSize: 25,color: deepdarkblue,fontWeight: FontWeight.bold),),
                          subtitle: Text(service.price.toString(),style: TextStyle(fontSize: 25,color: red)),
                          trailing: IconButton(
                              onPressed: () {
                                    _controller.addServicesForCustomer(customerModel.id, service.id);
                              },
                              icon: Icon(Icons.add,color: darkblue,size: 25)),
                        ),
                        SizedBox(
                          width: 170,
                          height: 110,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl:
                              service.image ?? "",
                              placeholder: (context, url) =>
                              const Icon(Icons.error),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: 50,
                              height: double.infinity,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
      },
      )
    );
  }
}
