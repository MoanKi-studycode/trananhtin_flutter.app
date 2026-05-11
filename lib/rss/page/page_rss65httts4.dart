import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trananhtin_flutter_app/rss/controller/rss_controller_simple.dart';
import 'package:trananhtin_flutter_app/rss/model/rss_item.dart';
import 'package:trananhtin_flutter_app/rss/page/page_view_rss65httts4.dart';

import '../model/rss_resource.dart';

class PageRss65httts4 extends StatelessWidget {
  PageRss65httts4({super.key});
  final SimpleControllerRss controller = Get.put(SimpleControllerRss());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<SimpleControllerRss>(
          id: "resourceName",
          builder: (controller) => Text(controller.currentResourceName),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          GetBuilder<SimpleControllerRss>(
              id: "header",
              init: controller,
              builder: (controller){
                List<String> headers = controller.headerResources;
                return DropdownButton<String>(
                    value: controller.resourceHeader,
                    items: controller.headerResources.map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        )
                    ).toList(),
                    onChanged: (value){
                      controller.changeResourceHeader(value!);
                    }
                );
              }
          ),
        ],
      ),
      drawer: Drawer(
        child: GetBuilder<SimpleControllerRss>(
          id: "controller",
          init: controller,
          builder: (controller) => Column(
              children: [
                UserAccountsDrawerHeader(
                    accountName: Text('Tran Anh Tin'),
                    accountEmail: Text('tin.ta.61cntt@ntu.edu.vn')
                ),
                Text('Sellect Source'),
                RadioGroup<String>(
                    groupValue: controller.currentResourceName,
                    onChanged: (value){
                      controller.changeResource(value!);
                    },
                    child: Column(
                      children: controller.resources.map(
                          (e) => RadioListTile<String>(
                            title: Text(e.name),
                            value: e.name,
                            groupValue: controller.currentResourceName,
                            onChanged: (value){
                              controller.changeResource(value!);
                            },
                          )
                      ).toList(),
                    )
                )
              ],
            )

        )
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.readRss(),
        child: GetBuilder<SimpleControllerRss>(
          id: "rssList",
          init: controller,
          builder: (controller) {
            var rssItems = controller.rssList;
            if (rssItems.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  RssItem item = rssItems[index];
                  return InkWell(
                    onTap: () {
                      // Navigate to webview if needed
                      print("Navigate to: ${item.link}");
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                                    ? Image.network(
                                        item.imageUrl!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image, size: 50),
                                      )
                                    : const Icon(Icons.image, size: 50),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => PageViewRss65Httts4(
                                          link: item.link?? "No url",
                                          resourceName: controller.currentResourceName,
                                        ),
                                      )
                                    );
                                  },
                                    child: Text(
                                    item.title ?? "No Title",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item.description ?? "",
                            style: TextStyle(color: Colors.grey[700]),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (item.pubDate != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                item.pubDate!,
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: rssItems.length,
              ),
            );
          },
        ),
      ),
    );
  }
}
