// ignore_for_file: must_be_immutable

import 'package:employee_parking/helper/constant.dart';
import 'package:employee_parking/view/services_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/customer/customer_controller.dart';

class AllCustomerView extends StatelessWidget {
  final CustomerController _customer = Get.put(CustomerController());
  int? floor;
  int? parkingID;

  AllCustomerView({super.key, this.floor, this.parkingID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                        () => InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          splashColor: darkblue,
                          onTap: () {
                            _customer.changeColor(index);
                          },
                          child: Container(
                            width: 197,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.6, color: darkblue),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(23),
                              ),
                              color: _customer.getColorButtons(index),
                            ),
                            child: Text(
                              _customer.text[index],
                              style: TextStyle(
                                color: _customer.getColorText(index),
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                fontFamily: 'Playfair Display1',
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(width: 5),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GetBuilder<CustomerController>(
                  init: CustomerController(),
                  builder: (controller) => controller.selectIndex == 0
                      ? FutureBuilder(
                          future: _customer.fetchCustomerActive(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: Padding(
                                padding: EdgeInsets.only(top: 280.0),
                                child: CircularProgressIndicator(),
                              ));
                            } else if (snapshot.hasError) {
                              return const Text("");
                            } else {
                              if (_customer.customerActive.isNotEmpty) {
                                return Obx(
                                  () => Expanded(
                                    child: ListView.builder(
                                      itemCount: _customer.customerActive.length,
                                      itemBuilder: (context, index) {
                                        var customer =
                                            _customer.customerActive[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 8),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                                height: 110,
                                                color: Colors.grey.shade50,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        customer.name,
                                                        style: TextStyle(
                                                            fontSize: 28,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                deepdarkblue),
                                                      ),
                                                      Text(
                                                        customer.number,
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.grey),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () async{
                                                               await _customer
                                                                    .customerExite(
                                                                        customer
                                                                            .id);
                                                                _customer.deleteCustomer(customer.id);
                                                              },
                                                              child: Container(
                                                                width: 110,
                                                                height: 30,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: red,
                                                                  border: Border.all(
                                                                      width:
                                                                          1.4,
                                                                      color:
                                                                          red),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  "Exite",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 15),
                                                            InkWell(
                                                              onTap: () {
                                                                Get.to(Services(customerModel: customer,));
                                                              },
                                                              child: Container(
                                                                width: 110,
                                                                height: 30,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      darkblue,
                                                                  border: Border.all(
                                                                      width:
                                                                          1.4,
                                                                      color:
                                                                          darkblue),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  "Services",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 15),
                                                            InkWell(
                                                              onTap: () {
                                                                _customer
                                                                    .showBookCustomer(
                                                                        customer
                                                                            .id,
                                                                        parkingID ??
                                                                            0,
                                                                        floor ??
                                                                            0);
                                                              },
                                                              child: Container(
                                                                width: 110,
                                                                height: 30,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      deepdarkblue,
                                                                  border: Border.all(
                                                                      width:
                                                                          1.4,
                                                                      color:
                                                                          deepdarkblue),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  "Book",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                return const Text('');
                              }
                            }
                          })
                      : FutureBuilder(
                          future: _customer.fetchCustomer(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: Padding(
                                padding: EdgeInsets.only(top: 280.0),
                                child: CircularProgressIndicator(),
                              ));
                            } else if (snapshot.hasError) {
                              return const Text("");
                            } else {
                              if (_customer.customer.isNotEmpty) {
                                return Obx(
                                  () => Expanded(
                                    child: ListView.builder(
                                      itemCount: _customer.customer.length,
                                      itemBuilder: (context, index) {
                                        var customer =
                                            _customer.customer[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 8),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                                height: 110,
                                                color: Colors.grey.shade50,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      width: 100,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: const Icon(
                                                          Icons.person,
                                                          size: 70,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15,
                                                              left: 15,
                                                              right: 15),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            customer.name,
                                                            style: TextStyle(
                                                                fontSize: 28,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    deepdarkblue),
                                                          ),
                                                          Text(
                                                            customer.number,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 30,
                                                                    top: 8),
                                                            child: InkWell(
                                                              onTap: () {
                                                                _customer
                                                                    .customerEntry(
                                                                        customer
                                                                            .id);
                                                              },
                                                              child: Container(
                                                                width: 210,
                                                                height: 30,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      darkblue,
                                                                  border: Border.all(
                                                                      width:
                                                                          1.4,
                                                                      color:
                                                                          darkblue),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  "Entery",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                return const Text('das');
                              }
                            }
                          }))
            ],
          )),
    );
  }
}
