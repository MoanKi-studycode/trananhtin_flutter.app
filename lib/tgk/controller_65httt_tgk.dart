import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller65htttTgk extends GetxController {
  final TextEditingController cm = TextEditingController(text: "0.0");
  final TextEditingController inch = TextEditingController(text: "0.0");
  
  final FocusNode cmFocus = FocusNode();
  final FocusNode inchFocus = FocusNode();

  var ketQuaCm = "".obs;
  var ketQuaInch = "".obs;

  void convertCmToInch(String value) {
    double val = double.tryParse(value) ?? 0.0;
    double res = val / 2.54;
    inch.text = res.toStringAsFixed(2);
    ketQuaCm.value = "${val.toStringAsFixed(1)} cm = ${res.toStringAsFixed(2)} inch";
    inchFocus.requestFocus();
    update(["tgk"]);
  }

  void convertInchToCm(String value) {
    double val = double.tryParse(value) ?? 0.0;
    double res = val * 2.54;
    cm.text = res.toStringAsFixed(2);
    ketQuaInch.value = "${val.toStringAsFixed(1)} inch = ${res.toStringAsFixed(2)} cm";
    cmFocus.requestFocus();
    update(["tgk"]);
  }

  List<String> get ketQuas {
    List<String> results = [];
    if (ketQuaCm.value.isNotEmpty) results.add(ketQuaCm.value);
    if (ketQuaInch.value.isNotEmpty) results.add(ketQuaInch.value);
    return results;
  }
  
  @override
  void onClose() {
    cmFocus.dispose();
    inchFocus.dispose();
    super.onClose();
  }
}
