import 'package:flutter/material.dart';

class UIExample extends StatefulWidget {
  const UIExample({super.key});

  @override
  State<UIExample> createState() => _UIExampleState();
}

class _UIExampleState extends State<UIExample> {
  var txtName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App cua Tran Tin'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: ClipOval(
                  child: Image.network
                    ("https://hoanghamobile.com/tin-tuc/wp-content/uploads/2023/07/hinh-dep.jpg", height: 150, width: 200, fit: BoxFit.cover,),
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.yellow,),
                  Icon(Icons.star, color: Colors.yellow,),
                  Icon(Icons.star, color: Colors.yellow,),
                  Icon(Icons.star, color: Colors.yellow,),
                  Icon(Icons.star_half, color: Colors.yellow,),
                  SizedBox(width: 30,),
                  Text("4.5", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 100,
                      color: Colors.red,
                      child: Text("Red"),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 100,
                      color: Colors.blue,
                      child: Text("Blue"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 100,
                      color: Colors.yellow,
                      child: Text("Yellow"),
                    ),
                  ),
                ],
              ),
                SizedBox(height: 30,),
                TextField(
                  controller: txtName,
                  decoration: InputDecoration(
                    labelText: "Write your phone number: "
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ElevatedButton(
                  onPressed: (){
                    setState(() {

                    });
                  },
                  child: Text("Message")
              ),
              Text("Call me! ${txtName.text}")
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("This is my picture!"),
              duration: Duration(seconds: 2),
            ));
      }),
    );
  }
}
