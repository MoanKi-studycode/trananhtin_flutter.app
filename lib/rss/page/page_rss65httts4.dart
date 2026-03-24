import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trananhtin_flutter_app/rss/controller/rss_controller_simple.dart';
import 'package:trananhtin_flutter_app/rss/model/rss_item.dart';

class PageRss65httts4 extends StatelessWidget {
  PageRss65httts4({super.key});
  final SimpleControllerRss controller = Get.put(SimpleControllerRss());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.currentResourceName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
