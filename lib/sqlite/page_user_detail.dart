import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trananhtin_flutter_app/sqlite/provider_data.dart';
import 'package:trananhtin_flutter_app/sqlite/sqlite_data.dart';

class PageUserSQLiteDetail extends StatefulWidget {
  final bool? xem;
  final User? user;
  const PageUserSQLiteDetail({super.key, this.xem, this.user});

  @override
  State<PageUserSQLiteDetail> createState() => _PageUserSQLiteDetailState();
}

class _PageUserSQLiteDetailState extends State<PageUserSQLiteDetail> {
  bool? xem;
  User? user;
  String title = "Infomation of User";
  String buttonTitle = "Close";
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('Building detail page with title: $title');
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: txtTen,
                decoration: InputDecoration(label: Text("Name:")),
              ),
              SizedBox(height: 10),
              TextField(
                controller: txtPhone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(label: Text("Phone:")),
              ),
              SizedBox(height: 10),
              TextField(
                controller: txtEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(label: Text("Email:")),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => _capnhat(context),
                    child: Text(buttonTitle),
                  ),
                  SizedBox(height: 10),
                  xem == true
                      ? SizedBox(width: 1)
                      : ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text("Close"),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    try {
      xem = widget.xem;
      user = widget.user;

      if (user != null) {
        if (xem != true) {
          buttonTitle = "Update";
          title = "Edit infomation";
        }
        txtTen.text = user!.name ?? '';
        txtPhone.text = user!.phone ?? '';
        txtEmail.text = user!.email ?? '';
      } else {
        buttonTitle = "Add";
        title = "Add User";
      }
    } catch (e) {
      print('Form Error: $e');
      title = "Error";
      buttonTitle = "Close";
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtTen.dispose();
    txtEmail.dispose();
    txtPhone.dispose();
  }

  void _capnhat(BuildContext context) async {
    try {
      print('=== Save User ===');
      final messenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);
      if (xem == true) {
        navigator.pop();
        return;
      }

      print('Getting provider');
      DatabaseProvider provider = context.read<DatabaseProvider>();
      User nUser = User(
        name: txtTen.text.trim(),
        phone: txtPhone.text.trim(),
        email: txtEmail.text.trim(),
      );
      print('Data: ${nUser.name}');

      if (user == null) {
        print('INSERT...');
        int id = await provider.insertUser(nUser);
        print('Result: $id');
        if (mounted) {
          if (id > 0) {
            messenger.showSnackBar(
              SnackBar(
                content: Text("✓ Added ${nUser.name}"),
                duration: const Duration(seconds: 3),
              ),
            );
            navigator.pop();
          } else {
            messenger.showSnackBar(
              SnackBar(
                content: Text("✗ Failed"),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        }
        return;
      }

      print('UPDATE ${user!.id}...');
      int count = await provider.updateUser(nUser, user!.id!);
      print('Result: $count');
      if (mounted) {
        if (count > 0) {
          messenger.showSnackBar(
            SnackBar(
              content: Text("✓ Updated ${user!.name!}"),
              duration: const Duration(seconds: 3),
            ),
          );
          navigator.pop();
        } else {
          messenger.showSnackBar(
            SnackBar(
              content: Text("✗ Failed"),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      print('ERROR: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
