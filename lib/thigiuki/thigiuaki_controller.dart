import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatHang {
  String ten;
  int dongia, soluong;
  MatHang({required this.ten, required this.dongia, required this.soluong});
}

class ThigiuakiController extends GetxController {
  final ds = <MatHang>[];
  final ten = TextEditingController();
  final dongia = TextEditingController();
  final soluong = TextEditingController();

  static ThigiuakiController get instance => Get.find<ThigiuakiController>();

  int get slmh => ds.length;

  void add() {
    ds.add(MatHang(
      ten: ten.text,
      dongia: int.tryParse(dongia.text) ?? 0,
      soluong: int.tryParse(soluong.text) ?? 0,
    ));
    ten.clear();
    dongia.clear();
    soluong.clear();
    update(["thigiuki"]);
  }
}
