// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/services/services_controller.dart';
import '../helper/constant.dart';

class ServiceForCustomerView extends StatelessWidget {
  ServiceForCustomerView({Key? key}) : super(key: key);
  final ServicesController _controller = Get.put(ServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _controller.fetchServices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Text("");
          } else {
            return ListView.separated(
              itemCount: _controller.services.length,
              itemBuilder: (context, index) {
                return Card(
                    borderOnForeground: debugDisableShadows,
                    child: Obx(
                      () {

                        return ListTile(
                          leading: SizedBox(
                            width: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl:
                                _controller.services[index].userModel.image ?? "",
                                placeholder: (context, url) =>
                                const Icon(Icons.error),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                                fit: BoxFit.cover,
                                width: 50,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          title: Text(
                            "${_controller.services[index].userModel.name} ${_controller.services[index].userModel.nickName}",
                            style: TextStyle(
                                color: darkblue,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          subtitle: Text(
                            _controller.services[index].serviceInfo.name,
                            style: TextStyle(color: deepdarkblue, fontSize: 20),
                          ),
                          trailing:_controller.services[index].done == 0 ? MaterialButton(
                            onPressed: () {
                              _controller.doneServices(_controller.services[index].id);
                            },
                            color: darkblue,
                            child: const Text(
                              "Done..",
                              style: TextStyle(color: Colors.white),
                            ),
                          ) :  Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(Icons.done_all,color: red,size: 50),
                          ),
                        );
                      }
                    ),
                );
              }, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 25),
            );
          }
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Get.to(services());
      //   },
      //   backgroundColor: deepdarkblue,
      //   foregroundColor: grey,
      //   //  child: Text('add service to customer'),
      //   shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
      //   // mini: false,
      //   icon: Icon(Icons.add),
      //   label: Text('add service to customer'),
      // ),
    );
  }
}
