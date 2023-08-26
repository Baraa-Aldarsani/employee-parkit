import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_parking/controller/subscription/subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/constant.dart';

class CustomerSubscription extends StatelessWidget {
  CustomerSubscription({Key? key}) : super(key: key);
  final SubscriptionController _controller = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _controller.getSubUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Text("");
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _controller.subUser.value.subscription?.length ?? 0,
              itemBuilder: (context, i) {
                var sub = _controller.subUser.value.subscription?[i];
                return Column(
                  children: [
                    ListView.builder(
                      itemCount: sub?.userSub?.length ?? 0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var user = sub?.userSub![index].userModel;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 105,
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Container(
                                    height: 180,
                                    width: 130,
                                    padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl: user?.image ?? "",
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
                                    padding: const EdgeInsets.symmetric(
                                         horizontal: 15,vertical: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${user?.name} ${user?.nickName}",
                                          style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: deepdarkblue),
                                        ),
                                        Text(
                                          user?.phone ?? "",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.grey),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              sub!.userSub![index].startDate,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: darkblue),
                                            ),
                                            const SizedBox(width: 5),
                                            const Text("---->"),
                                            const SizedBox(width: 5),
                                            Text(
                                              sub.userSub![index].endDate,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: darkblue),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Get.to(const subscriptions());
      //   },
      //   backgroundColor: deepdarkblue,
      //   foregroundColor: grey,
      //   shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
      //   icon: const Icon(Icons.add),
      //   label: const Text('add subscription to customer'),
      // ),
    );
  }
}
