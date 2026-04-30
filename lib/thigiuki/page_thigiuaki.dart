import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trananhtin_flutter_app/thigiuki/thigiuaki_controller.dart';

class PageThigiuaki extends StatelessWidget {
  const PageThigiuaki({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trần Anh Tín"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
          child: GetBuilder<ThigiuakiController>(
              id: "thigiuki",
              init: ThigiuakiController(),
              builder: (controller){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Danh sách mặt hàng:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    Divider(),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(10),
                        itemCount: controller.slmh,
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.ds[index].ten, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                  Text("Đơn giá: ${controller.ds[index].dongia} vnđ"),
                                ]
                              ),
                              SizedBox(width: 20,),
                              Text("số lượng: ${controller.ds[index].soluong}", style: TextStyle(fontSize: 12),),
                            ],
                          );
                        },
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(),
                        Text("Danh sách có : ${controller.slmh} sản phẩm"),
                        Divider(),
                        Text("Mặt hàng: "),
                        TextField(
                          controller: controller.ten,
                        ),
                        Text("Đơn giá: "),
                        TextField(
                          controller: controller.dongia,
                        ),
                        Text("Số lượng: "),
                        TextField(
                          controller: controller.soluong,
                        ),
                      ],
                    ),
                  ]
                );
              }
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ThigiuakiController.instance.add();
        },
        child: Text("Thêm"),
      ),
    );
  }
}
