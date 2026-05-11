import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:trananhtin_flutter_app/helper/dialogs.dart';
import 'package:trananhtin_flutter_app/sqlite/page_user_detail.dart';
import 'package:trananhtin_flutter_app/sqlite/provider_data.dart';
import 'package:trananhtin_flutter_app/sqlite/sqlite_data.dart';

class PageListUserSQLite extends StatefulWidget {
  const PageListUserSQLite({Key? key}) : super(key: key);

  @override
  State<PageListUserSQLite> createState() => _PageListUserSQLiteState();
}

class _PageListUserSQLiteState extends State<PageListUserSQLite> {
  BuildContext? _dialogContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLite Demo"),
        actions: [
          IconButton(
            onPressed: () {
              try {
                print('Add button tapped');
                // Get the current provider from context
                DatabaseProvider provider = context.read<DatabaseProvider>();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider.value(
                      value: provider,
                      child: PageUserSQLiteDetail(),
                    ),
                  ),
                );
              } catch (e) {
                print('Error navigating to add page: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            },
            icon: Icon(Icons.add_circle_outline, color: Colors.white),
          ),
        ],
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, databaseProvider, child) {
          if (databaseProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (databaseProvider.users == null || databaseProvider.users!.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.list_alt, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    "No users found. Tap + to add a user.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(thickness: 1),
            itemCount: databaseProvider.users!.length,
            itemBuilder: (context, index) {
              _dialogContext = context;
              User user = databaseProvider.users![index];
              return Slidable(
                child: ListTile(
                  leading: Text(
                    "${user.id}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: Text(
                    "${user.name}",
                    style: const TextStyle(fontSize: 18, color: Colors.indigo),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone: ${user.phone}"),
                      Text("Email: ${user.email}"),
                    ],
                  ),
                ),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                            value: databaseProvider,
                            child: PageUserSQLiteDetail(xem: true, user: user),
                          ),
                        ),
                      ),
                      icon: Icons.details,
                      foregroundColor: Colors.green,
                      backgroundColor: Colors.green[50]!,
                    ),
                    SlidableAction(
                      onPressed: (context) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                            value: databaseProvider,
                            child: PageUserSQLiteDetail(xem: false, user: user),
                          ),
                        ),
                      ),
                      icon: Icons.edit,
                      foregroundColor: Colors.blue,
                      backgroundColor: Colors.blue[50]!,
                    ),
                    SlidableAction(
                      onPressed: (context) => _xoa(_dialogContext, user),
                      icon: Icons.delete_forever,
                      foregroundColor: Colors.red,
                      backgroundColor: Colors.red[50]!,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    DatabaseProvider provider = context.read<DatabaseProvider>();
    provider.closeDatabase();
    super.dispose();
  }

  void _xoa(BuildContext? dialogContext, User user) async {
    final provider = context.read<DatabaseProvider>();
    String? confirm = await showConfirmDialog(
      context,
      "Do you want to delete ${user.name!}",
    );
    if (confirm == "ok") {
      provider.deleteUser(user.id!);
    }
  }
}
