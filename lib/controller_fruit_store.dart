import 'package:get/get.dart';
import 'package:trananhtin_flutter_app/Fruit.dart';
import 'package:trananhtin_flutter_app/cart.dart';

class ControllerFruitStore extends GetxController {
  Map<int, Fruit> mapFruits = {};
  Map<int, GioHangItem> gioHang = {};

  int get slMHGH => gioHang.length;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    FruitSnapshot.getMapFruitHTTT().then(
        (value) {
          mapFruits = value;
          update(["fruits"]);
        }
    ).onError(
        (error, stackTrace) {
          print("Can't read data from server: $error");
        }
    );
  }

  bool themMH_vao_GH(Fruit f){
    if(gioHang.containsKey(f.id)){
      gioHang[f.id]!.soluong+=1;
      return false;
    }
    gioHang[f.id] = GioHangItem(id: f.id);
    update(["gioHang"]);
    return true;
  }

  int tongTien(){
    int tong = 0;
    for(var item in gioHang.values){
      if(item.chon == true) {
        tong += item.soluong * (mapFruits[item.id]!.gia ?? 0);
      }
    }
    return tong;
  }
  void giamMH(Fruit f) {
    if (gioHang.containsKey(f.id)) {
      if (gioHang[f.id]!.soluong > 1) {
        gioHang[f.id]!.soluong--;
        update(["gioHang"]);
      }
    }
  }
  void tangMH(Fruit f) {
    if (gioHang.containsKey(f.id)) {
      gioHang[f.id]!.soluong++;
      update(["gioHang"]);
    }
  }
}