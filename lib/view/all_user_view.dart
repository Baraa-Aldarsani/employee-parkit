import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_parking/controller/customer/customer_controller.dart';
import 'package:employee_parking/controller/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/constant.dart';

class AllUser extends StatelessWidget {
  final _user = Get.put(UserController());
  String? barcode;
  int? floor;
  int? parkingID;
  AllUser({super.key, this.barcode,this.parkingID,this.floor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: FutureBuilder(
                 future: _user.fetchActiveUser(),
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
                     if (_user.activeUser.isNotEmpty) {
                       return Obx(
                             () => ListView.builder(
                               itemCount: _user.activeUser.length,
                               itemBuilder: (context, index) {
                                 var activeUser =
                                 _user.activeUser.value[index];
                                 return Padding(
                                   padding: const EdgeInsets.symmetric(
                                       horizontal: 6, vertical: 8),
                                   child: ClipRRect(
                                     borderRadius:
                                     BorderRadius.circular(20),
                                     child: Container(
                                         height: 130,
                                         color: Colors.grey.shade50,
                                         child: Row(
                                           children: [
                                             Container(
                                               height: 180,
                                               width: 130,
                                               padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
                                               child: ClipRRect(
                                                 borderRadius: BorderRadius.circular(20),
                                                 child: CachedNetworkImage(
                                                   imageUrl: activeUser.image ?? "",
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
                                                     "${activeUser.name} ${activeUser.nickName}",
                                                     style: TextStyle(
                                                         fontSize: 28,
                                                         fontWeight:
                                                         FontWeight
                                                             .bold,
                                                         color:
                                                         deepdarkblue),
                                                   ),
                                                   Text(
                                                     activeUser.phone,
                                                     style:
                                                     const TextStyle(
                                                         fontSize:
                                                         20,
                                                         color: Colors
                                                             .grey),
                                                   ),
                                                   Expanded(
                                                     child: Row(
                                                       children: [
                                                         InkWell(
                                                           onTap: () {
                                                             _user.userExite(
                                                                 activeUser.id.toString() ?? '',activeUser.carID.toString() ?? '');
                                                           },
                                                           child:
                                                           Container(
                                                             width: 110,
                                                             height: 30,
                                                             alignment:
                                                             Alignment
                                                                 .center,
                                                             decoration:
                                                             BoxDecoration(
                                                               color:
                                                               red,
                                                               border: Border.all(
                                                                   width:
                                                                   1.4,
                                                                   color:
                                                                   red),
                                                               borderRadius:
                                                               const BorderRadius
                                                                   .all(
                                                                 Radius.circular(
                                                                     10),
                                                               ),
                                                             ),
                                                             child:
                                                             const Text(
                                                               "Exite",
                                                               style: TextStyle(
                                                                   color:
                                                                   Colors.white),
                                                             ),
                                                           ),
                                                         ),
                                                         const SizedBox(
                                                             width: 10),
                                                         InkWell(
                                                           onTap: () {
                                                             _user.showBookUser(activeUser.id,activeUser.carID ?? 0,parkingID ?? 0,floor ?? 0);
                                                           },
                                                           child:
                                                           Container(
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
                                                                 Radius.circular(
                                                                     10),
                                                               ),
                                                             ),
                                                             child:
                                                             const Text(
                                                               "Book",
                                                               style: TextStyle(
                                                                   color:
                                                                   Colors.white),
                                                             ),
                                                           ),
                                                         ),
                                                       ],
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
                       );
                     } else {
                       return const Text('');
                     }
                   }
                 }))
    );
  }
}
