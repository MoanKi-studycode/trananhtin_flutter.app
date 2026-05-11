import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'Fruit.dart';
import 'controller_fruit_store.dart';
import 'package:badges/badges.dart' as badges;

class PageFruitHtttc7 extends StatelessWidget {
  PageFruitHtttc7({super.key});
  final controller = Get.put(ControllerFruitStore());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("65HTTTC7"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          GetBuilder<ControllerFruitStore>(
            id: "gioHang",
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: IconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PageGioHang()),
                  ),
                  icon: badges.Badge(
                    showBadge: controller.slMHGH > 0,
                    badgeContent: Text(
                      "${controller.slMHGH}",
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(Icons.shopping_cart, color: Colors.red),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: GetBuilder(
          id: "fruits",
          init: controller,
          builder: (controller) {
            var interable = controller.mapFruits.values;
            return GridView.extent(
              maxCrossAxisExtent: 300,
              crossAxisSpacing: 5,
              childAspectRatio: 0.7,
              children: interable.map((e) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PageChiTietHTTTC7(fruit: e),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Image.network(e.anh ?? "No image"),
                      Text(e.ten),
                      Text(
                        "${e.gia ?? 0}",
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(e.moTa ?? "No description"),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class PageChiTietHTTTC7 extends StatelessWidget {
  PageChiTietHTTTC7({super.key, required this.fruit});
  final controller = Get.put(ControllerFruitStore());
  Fruit fruit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fruit.ten),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          GetBuilder<ControllerFruitStore>(
            id: "gioHang",
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: IconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PageGioHang()),
                  ),
                  icon: badges.Badge(
                    showBadge: controller.slMHGH > 0,
                    badgeContent: Text(
                      "${controller.slMHGH}",
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(Icons.shopping_cart, color: Colors.red),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(fruit.anh ?? "No image"),
              SizedBox(height: 15),
              Text(fruit.ten, style: TextStyle(fontSize: 20)),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    "${fruit.gia ?? 0} vnd",
                    style: TextStyle(fontSize: 20, color: Colors.yellow),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "${fruit.gia ?? 0} vnd",
                    style: TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star_half, color: Colors.yellow),
                  SizedBox(width: 20),
                  Text("100 Votes", style: TextStyle(fontSize: 20)),
                ],
              ),
              SizedBox(height: 20),
              Text(
                fruit.moTa ?? "No description",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var check = controller.themMH_vao_GH(fruit);
          if (!check) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Added ${fruit.ten} in to cart ${controller.gioHang[fruit.id]!.soluong}",
                ),
              ),
            );
          }
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class PageGioHang extends StatelessWidget {
  PageGioHang({super.key});
  final controller = Get.put(ControllerFruitStore());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart shop (${controller.slMHGH})"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: GetBuilder<ControllerFruitStore>(
          id: "gioHang",
          builder: (controller) {
            if (controller.gioHang.isEmpty) {
              return Center(child: Text("Nothing in Cart"));
            }
            var cartItems = controller.gioHang.values.toList();
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(10),
                    itemCount: controller.slMHGH,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      var item = cartItems[index];
                      var fruit = controller.mapFruits[item.id];
                      return Row(
                        children: [
                          Checkbox(
                            value: item.chon,
                            onChanged: (value) {
                              item.chon = value;
                              controller.update(["gioHang"]);
                            },
                          ),
                          SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.network(fruit!.anh ?? "No image")
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fruit.ten,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("Price: ${fruit.gia} vnd"),
                                    IconButton(
                                      onPressed: () {
                                        controller.giamMH(fruit);
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text("${item.soluong}"),
                                    IconButton(
                                      onPressed: () {
                                        controller.tangMH(fruit);
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text("Total pice:", style: TextStyle(fontSize: 20)),
                    ),
                    Text("${controller.tongTien()} vnd", style: TextStyle(fontSize: 20)),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
