import 'package:flutter/material.dart';
import 'package:trananhtin_flutter_app/Fruit.dart';

class PageFruitStream65httt extends StatelessWidget {
  const PageFruitStream65httt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruit store 65HTTT"),
        backgroundColor:  Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder(
          stream: FruitSnapshot.getFruitStreamHTTT(),
          builder: (context, snapshot){
            if(snapshot.hasError){
              print("Error!${snapshot.error}");
              return Center(
                child: Text("Error!!!", style: TextStyle(color: Colors.red)),
                );
            }
            if(!snapshot.hasData){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Loading...")
                    ],
                )
              );
            }
            List<Fruit> list = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: GridView.extent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.7,
                children: list.map(
                    (e){
                      return Column(
                        children: [
                          Image.network(e.anh?? "No image"),
                          Text(e.ten),
                          Text("${e.gia?? 0}"),
                          Text(e.moTa?? "No description"),
                        ],
                      );
                    }
                ).toList(),
              ),
            );
          },
      ),
    );
  }
}
