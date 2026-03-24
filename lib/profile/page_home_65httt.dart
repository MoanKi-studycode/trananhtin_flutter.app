import 'package:flutter/material.dart';
import 'package:trananhtin_flutter_app/profile/listview65httt.dart';
import 'package:trananhtin_flutter_app/profile/page_getx_65httt.dart';
import 'package:trananhtin_flutter_app/profile/profile64mmt.dart';
import 'package:trananhtin_flutter_app/rss/page/page_rss65httts4.dart';

class PageHome65HTTT extends StatefulWidget {
  const PageHome65HTTT({super.key});

  @override
  State<PageHome65HTTT> createState() => _PageHome65HTTTState();
}

class _PageHome65HTTTState extends State<PageHome65HTTT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            _buildButton(context, title: "My profile", destination: MyProfile()),
            _buildButton2(context, title: "Second Page", destination: PageSecond()),
            _buildButton(context, title: "List View", destination: PageListView65HTTT()),
            _buildButton(context, title: "Page GetX", destination: GetxApp65HTTT()),
            _buildButton(context, title: "Rss65Httts4", destination: PageRss65httts4()),
          ],
        ),
      ),
    );
  }
  Widget _buildButton(BuildContext context, {required String? title, required Widget? destination}){
    return Container(
      width: 200,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.purple[50]),
              elevation: WidgetStateProperty.all(2)
          ),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => destination!)
            );
          },
          child: Text(title!)
      ),
    );
  }

  Widget _buildButton2(BuildContext context, {required String? title, required Widget? destination}){
    return Container(
      width: 200,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.purple[50]),
              elevation: WidgetStateProperty.all(2)
          ),
          onPressed: () async {
            var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => destination!)
            );
            if(result != null){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Received $result")));
            }
          },
          child: Text(title!)
      ),
    );
  }
}

class PageSecond extends StatelessWidget {
  const PageSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop("Lucky bag 50k");
            },
            child: Text("Return")
        ),
      ),
    );
  }
}

