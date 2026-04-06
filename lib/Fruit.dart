import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as f;
import 'package:trananhtin_flutter_app/supabase_helper.dart';

class Fruit {
  int id;
  int? gia;
  String ten;
  String? moTa, anh;
  Fruit({
    required this.id,
    required this.gia,
    required this.ten,
    this.moTa,
    this.anh,
  });

  Fruit.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      gia = json["gia"],
      ten = json["ten"],
      moTa = json["moTa"];

  Map<String, dynamic> toJson() {
    return {'id': id, 'gia': gia, 'ten': ten, 'moTa': moTa, 'anh': anh};
  }

  factory Fruit.fromMap(Map<String, dynamic> map) {
    return Fruit(
      id: map['id'] as int,
      gia: map['gia'] != null ? int.tryParse(map['gia'].toString()) : null,
      ten: map['ten'] as String,
      moTa: map['moTa'] as String?,
      anh: map['anh'] as String?,
    );
  }
}

class FruitSnapshot {
  static Stream<List<Fruit>> getFruitStream() {
    final supabase = Supabase.instance.client;
    var stream = supabase.from('Fruit').stream(primaryKey: ['id']);
    return stream.map((event) => event.map((e) => Fruit.fromMap(e)).toList());
  }

  static Stream<List<Fruit>> getFruitStreamHTTT() {
    return getDataStream(
      table: "Fruit",
      ids: ["id"],
      fromMap: (map) => Fruit.fromMap(map),
    );
  }

  static Future<Map<int, Fruit>> getMapFruitHTTT() async {
    return getMapData(
      table: "Fruit",
      fromMap: (map) => Fruit.fromMap(map),
      getId: (t) => t.id,
    );
  }

  static Future<void> insert(Fruit f) async {
    await supabase.from('Fruit').insert(f.toJson());
  }

  static Future<void> update(Fruit f) async {
    await supabase.from('Fruit').update(f.toJson()).eq('id', f.id);
  }

  static listenFruitChange(Map<int, Fruit> maps, {Function()? updateUI}) {
    listenDataChange(
        maps,
        chanel: "public:Fruit",
        table: "Fruit",
        fromMap: (map) => Fruit.fromMap(map),
        getId: (t) => t.id,
        updateUI: updateUI
    );
  }
}
