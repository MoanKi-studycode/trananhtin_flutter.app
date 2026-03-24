import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  DateTime ngaySinh = DateTime(2001,7,25);
  String? gioiTinh = "Female";
  List<String> nnlts = ["Vietnamese", "No Language", "JAVA", "C++", "C#", "PyThon", "Dart"];
  String? nnlt = "No Language";
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tran Tin Profile"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("Tran Tin"),
                accountEmail: Text("tin.ta.61cntt@ntu.edu.vn"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("asset/images/profile.jpg"),
              ),
            ),
            ListTile(
              title: Text("SMS"),
              trailing: Text("10"),
              leading: Icon(Icons.sms),
              onTap: (){
                setState(() {
                  index = 1;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Setting"),
              leading: Icon(Icons.settings),
              onTap: (){
                setState(() {
                  index = 1;
                });
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
      body: _buildBody(index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
          onTap: (value){
            setState(() {
              index = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.grey,),
                label: "Home",
              activeIcon: Icon(Icons.home, color: Colors.blue,)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.sms, color: Colors.grey,),
                label: "Sms",
                activeIcon: Icon(Icons.sms, color: Colors.orange,)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings, color: Colors.grey,),
                label: "Setting",
                activeIcon: Icon(Icons.settings, color: Colors.black,)
            )
          ]
      ),
    );
  }
  Widget _buildHome(){
    return
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Center(
                child: Container(
                  width: 300, height: 200,
                  child: Image.asset("asset/images/profile.jpg"),
                ),
              ),
              SizedBox(height: 15,),
              Text("Name: "),
              Text("Tran Anh Tin", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 15,),
              Text("Born in: "),
              Row(
                children: [
                  Expanded(child: Text("${ngaySinh.day}/${ngaySinh.month}/${ngaySinh.year}")),
                  IconButton(
                    onPressed: () async{
                      var selectedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1990),
                          lastDate: DateTime(2050),
                          currentDate: ngaySinh
                      );
                      if(selectedDate!=null){
                        setState(() {
                          ngaySinh = selectedDate;
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_month),
                  ),
                  SizedBox(width: 20,)
                ],
              ),
              SizedBox(height: 15,),
              Text("Sex: "),
              RadioGroup(
                  groupValue: gioiTinh,
                  onChanged: (value){
                    setState(() {
                      gioiTinh = value;
                    });
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          value: "Female",
                          title: Text("Female"),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          value: "Male",
                          title: Text("Male"),
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(height: 15,),
              Text("Habit:"),
              Text("Money, Games, Books, ...", style: TextStyle(fontStyle: FontStyle.italic),),
              SizedBox(height: 15,),
              Text("My favorite language programing: "),
              DropdownButton<String>(
                  value: nnlt,
                  items: nnlts.map(
                          (e) => DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      )
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      nnlt = value;
                    });
                  }
              ),
            ],
          ),
        ),
      );
  }
  Widget _buildSMS(){
    return Center(
      child: Text("SMS", style: TextStyle(fontSize: 20),),
    );
  }
  Widget _buildSetting(){
    return Center(
      child: Text("Setting", style: TextStyle(fontSize: 20),),
    );
  }
  Widget _buildBody(int index){
    switch(index){
      case 0: return _buildHome();
      case 1: return _buildSMS();
      case 2: return _buildSetting();
    }
    return _buildHome();
  }
}
