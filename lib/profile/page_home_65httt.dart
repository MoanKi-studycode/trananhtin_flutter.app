import 'package:flutter/material.dart';
import 'package:trananhtin_flutter_app/form/page_form_mathang.dart';
import 'package:trananhtin_flutter_app/login/page_login.dart';
import 'package:trananhtin_flutter_app/page_fruit_htttc7.dart';
import 'package:trananhtin_flutter_app/page_fruit_stream_65httt.dart';
import 'package:trananhtin_flutter_app/phone/read_number.dart';
import 'package:trananhtin_flutter_app/profile/listview65httt.dart';
import 'package:trananhtin_flutter_app/profile/page_getx_65httt.dart';
import 'package:trananhtin_flutter_app/profile/profile64mmt.dart';
import 'package:trananhtin_flutter_app/rss/page/page_rss65httts4.dart';
import 'package:trananhtin_flutter_app/sqlite/page_sqlite_app.dart';
import 'package:trananhtin_flutter_app/tgk/page_65httt_tgk.dart';
import 'package:trananhtin_flutter_app/thigiuki/page_thigiuaki.dart';

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
        child: SingleChildScrollView(
          child: Column(
          children: [
            _buildButton(
              context,
              title: "My profile",
              destination: MyProfile(),
            ),
            _buildButton2(
              context,
              title: "Second Page",
              destination: PageSecond(),
            ),
            _buildButton(
              context,
              title: "List View",
              destination: PageListView65HTTT(),
            ),
            _buildButton(
              context,
              title: "Page GetX",
              destination: GetxApp65HTTT(),
            ),
            _buildButton(
              context,
              title: "Rss65Httts4",
              destination: PageRss65httts4(),
            ),
            _buildButton(
              context,
              title: "FruitStore",
              destination: PageFruitStream65httt(),
            ),
            _buildButton(
              context,
              title: "FruitStoreC7",
              destination: PageFruitHtttc7(),
            ),
            _buildButton(
              context,
              title: "PageTgk'",
              destination: Page65htttTgk(),
            ),
            _buildButton(
              context,
              title: "PageThiGiuaKi",
              destination: PageThigiuaki(),
            ),
            _buildButton(
              context,
              title: "PageFormMatHang",
              destination: PageFormMathang(),
            ),
            _buildButton(
              context,
              title: "SQLite App",
              destination: SQLiteApp(),
            ),
            _buildButton(
              context,
              title: "Page login",
              destination: PageLogin(),
            ),
            _buildButton(
              context,
              title: "Page verify",
              destination: PageVerifyUser(email: "anhtin@gmail.com"),
            ),
            _buildButton(
              context,
              title: "Page call",
              destination: PageCall(),
            ),
          ],
        ),
        ) 
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String title,
    required Widget destination,
  }) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.purple[50]),
          elevation: MaterialStateProperty.all(2),
        ),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => destination));
        },
        child: Text(title),
      ),
    );
  }

  Widget _buildButton2(
    BuildContext context, {
    required String title,
    required Widget destination,
  }) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.purple[50]),
          elevation: MaterialStateProperty.all(2),
        ),
        onPressed: () async {
          var result = await Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => destination));
          if (result != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Received $result")));
          }
        },
        child: Text(title),
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
          child: Text("Return"),
        ),
      ),
    );
  }
}
