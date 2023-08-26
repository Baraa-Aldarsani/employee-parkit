import 'package:employee_parking/controller/user/user_controller.dart';
import 'package:employee_parking/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/barcode_controller.dart';
import '../controller/control_controller.dart';
import '../helper/clipper_scan.dart';

class ScanCameraView extends StatelessWidget {
  ScanCameraView({super.key});

  final BarcodeController _controller = Get.put(BarcodeController());
  final UserController _user = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Container(
                height: 300,
                child: ClipPath(
                  clipper: TsClip2(),
                  child: Container(
                    color: deepdarkblue,
                    height: 200,
                  ),
                )),
            const Image(
              image: AssetImage('assets/images/scanview.png'),
              width: 420,
              height: 250,
              alignment: Alignment.center,
            ),
          ]),
          const SizedBox(
            height: 40,
          ),

          const SizedBox(height: 40),
          Obx(() => Text(
                "${_controller.barcodeResult.value} : ${_controller.barcodeScan}",
                style: const TextStyle(fontSize: 18),
              )),
          const SizedBox(height: 40),
          GetBuilder<ControlController>(
            init: ControlController(),
            builder: (controller) => MaterialButton(
              onPressed: () {
                if (_controller.barcodeScan.value != '') {
                  _user.payment(_controller.barcodeScan.value.split('-')[1]);
                }
                _controller.barcodeScan.value = '';
                _controller.update();
              },
              color: deepdarkblue,
              minWidth: 300,
              height: 50,
              child: Text(
                "Pay a Charge",
                style: TextStyle(color: grey, fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 10),
          MaterialButton(
            onPressed: () {
              if (_controller.barcodeScan.value != '') {
                _user.userEntry(_controller.barcodeScan.value.split('-')[1],
                    _controller.barcodeScan.value.split('-')[0]);
              }
              _controller.barcodeScan.value = '';
              _controller.update();
            },
            color: deepdarkblue,
            minWidth: 300,
            height: 50,
            child: Text(
              "Take up a parking ",
              style: TextStyle(color: grey, fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              if (_controller.barcodeScan.value != '') {
                _user.userExite(_controller.barcodeScan.value.split('-')[1],
                    _controller.barcodeScan.value.split('-')[0]);
              }
              _controller.barcodeScan.value = '';
              _controller.update();
            },
            color: deepdarkblue,
            minWidth: 300,
            height: 50,
            child: Text(
              "Take out a car",
              style: TextStyle(color: grey, fontSize: 18),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 80,
        width: 80,
        child: FloatingActionButton(
          backgroundColor: deepdarkblue,
          onPressed: () => _controller.scanBarcode(),
          child: const Icon(
            Icons.barcode_reader,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}
