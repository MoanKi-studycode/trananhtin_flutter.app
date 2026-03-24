import 'dart:math';

import 'package:flutter/material.dart';

var data = ["Banana", "Coconut", "Mango", "Durian", " Apple", "Oranges", "Waterlemon", "Fruist"
];
class PageListView65HTTT extends StatelessWidget {
  const PageListView65HTTT({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruit store"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(data[index]),
              trailing: Text("${Random().nextInt(100)} kg"),
              subtitle: Text("${Random().nextInt(100)}.000 VND"),
              leading: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmNmtiKe1ts_QSG_scLRR7f46Q7Jha-zPvJw&s"),
              onTap: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("You choose: ${data[index]}"))
                );
              },
            );
          },
          separatorBuilder: (context, index) => Divider(thickness: 5),
          itemCount: data.length,
      ),
    );
  }
}
