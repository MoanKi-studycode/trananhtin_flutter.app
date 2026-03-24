import 'package:flutter/material.dart';
import 'package:trananhtin_flutter_app/home.dart';
import 'package:trananhtin_flutter_app/profile/page_getx_65httt.dart';
import 'package:trananhtin_flutter_app/profile/page_home_65httt.dart';
import 'package:trananhtin_flutter_app/profile/profile64mmt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(


        colorScheme: .fromSeed(seedColor: Colors.redAccent),
      ),
      home: PageHome65HTTT(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  void _decremementCounter(){
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: .center,
          children: [
            Text("Day la app dau tien cua tui!!!"),
            const Text('Bấm vào nút dấu + để tăng giá trị:', style: TextStyle(fontSize: 18, color: Colors.red),),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text("Xin thay cho 10 diem!!!", style: TextStyle(fontSize: 20, color:Colors.blue),),
            Row(
              mainAxisAlignment: .center,
              children: [
                ElevatedButton(

                    onPressed: () => _decremementCounter(),
                    child: Text("-", style: TextStyle(fontSize: 30),)
                ),
                const SizedBox(width: 20,),
                ElevatedButton(
                    onPressed: () => _incrementCounter(),
                    child: Text("+", style: TextStyle(fontSize: 30),)
                )
              ]

            )

          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _counter = 10;
  }
}
