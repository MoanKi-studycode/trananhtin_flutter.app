import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trananhtin_flutter_app/tgk/controller_65httt_tgk.dart';

class Page65htttTgk extends StatelessWidget {
  Page65htttTgk({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Tran Anh Tin 65HTTT"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GetBuilder<Controller65htttTgk>(
        id: "tgk",
        init: Controller65htttTgk(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Chiều dài (cm):"),
                TextField(
                  controller: controller.cm,
                  keyboardType: TextInputType.number,
                  focusNode: controller.cmFocus,
                  onChanged: (value) {},
                  decoration: InputDecoration(hintText: "Nhập số cm"),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => controller.convertCmToInch(controller.cm.text),
                      child: Icon(Icons.arrow_downward, size: 30,),
                    ),
                    SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: () => controller.convertInchToCm(controller.inch.text),
                      child: Icon(Icons.arrow_upward, size: 30),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Text("Chiều dài (inch): "),
                TextField(
                  controller: controller.inch,
                  keyboardType: TextInputType.number,
                  focusNode: controller.inchFocus,
                  onChanged: (value) {},
                  decoration: InputDecoration(hintText: "Nhập số inch"),
                ),
                SizedBox(height: 5),
                Text(
                  "Kết quả tính toán: ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Divider(),
                SizedBox(height: 10),
                Expanded(
                  child: Obx(() => ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: controller.ketQuas.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(controller.ketQuas[index]),
                      );
                    },
                  )),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
