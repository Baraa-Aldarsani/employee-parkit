import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class BarcodeController extends GetxController {
  var barcodeResult = "Scanning...".obs;
  var barcodeScan = ''.obs;

  Future<void> scanBarcode() async {
    String barcodeValue = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.BARCODE,
    );
    if (barcodeValue != '-1') {
      barcodeResult.value = "The barcode has been successfully scanned";
      barcodeScan.value = barcodeValue;
    } else {
      barcodeResult.value = "No barcodes have been scanned";
    }
  }
}