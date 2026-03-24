import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trananhtin_flutter_app/profile/controller_counter.dart';

class GetxApp65HTTT extends StatelessWidget {
  const GetxApp65HTTT({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsController65HTTT(),
      home: PageGetxCounter65HTTT(),
    );
  }
}


class PageGetxCounter65HTTT extends StatelessWidget {const PageGetxCounter65HTTT({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerCounter65HTTT controller1 = Get.find<ControllerCounter65HTTT>();
    final ControllerCounter65HTTT2 controller2 = Get.find<ControllerCounter65HTTT2>();
    return Scaffold(
      appBar: AppBar(
        title: Text ("Getx Controller"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
              Obx(() => Text("Obx: ${controller1.counter.value}"),),
            GetX<ControllerCounter65HTTT>(
              init: controller1,
              builder: (controller) => Text("Obx: ${controller1.counter.value}"),
            ),
            GetBuilder<ControllerCounter65HTTT2>(
              init: Get.put(ControllerCounter65HTTT2()),
                id: "01",
                builder: (controller) => Text("GetBuilder(counter): ${controller.counter}")
            ),
            GetBuilder<ControllerCounter65HTTT2>(
                init: controller2,
                id: "02",
                builder: (controller) => Text("GetBuilder(sum): ${controller.sum}")
            ),
            ElevatedButton(
                onPressed: (){
                  controller1.increment();
                  controller2.increment();
                },
                child: Text ("Increment")
            ),
            ElevatedButton(
                onPressed: (){
                  controller2.increment();
                },
                child: Text ("Increment GetBuilder")
            ),
          ],
        ),
      ),
    );
  }
}
