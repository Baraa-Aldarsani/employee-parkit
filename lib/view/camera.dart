
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class BarcodeController extends GetxController {
  var barcodeResult = "انقر على زر المسح للبدء".obs;

  Future<void> scanBarcode() async {
    String barcodeValue = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "إلغاء",
      false,
      ScanMode.DEFAULT,
    );

    if (barcodeValue != '-1') {
      barcodeResult.value = "الباركود: $barcodeValue";
    } else {
      barcodeResult.value = "لم يتم مسح أي باركود";
    }
  }
}

class CameraView extends StatefulWidget {
  final CameraDescription camera;

  CameraView({required this.camera});

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final BarcodeController _barcodeController = Get.put(BarcodeController());

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('معاينة الكاميرا مع مسح الباركود')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Obx(
                () => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _barcodeController.barcodeResult.value,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _barcodeController.scanBarcode(),
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


