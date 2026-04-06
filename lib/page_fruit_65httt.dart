import 'package:flutter/material.dart';
import 'package:trananhtin_flutter_app/Fruit.dart';

class PageFruit65httt extends StatelessWidget {
  const PageFruit65httt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruit store 65HTTT"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: FutureBuilder<Map<int, Fruit>>(
          future: FruitSnapshot.getMapFruitHTTT(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("Error!" + snapshot.error.toString());
              return Center(
                child: Text("Error!!!", style: TextStyle(color: Colors.red)),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator(), Text("Loading...")],
                ),
              );
            }
            var interable = snapshot.data!.values.toList();
            return GridView.extent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 5,
              childAspectRatio: 0.7,
              children: interable.map((e) {
                return Column(
                  children: [
                    Image.network(e.anh ?? "No image"),
                    Text(e.ten),
                    Text("${e.gia ?? 0}"),
                    Text(e.moTa ?? "No description"),
                  ],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
