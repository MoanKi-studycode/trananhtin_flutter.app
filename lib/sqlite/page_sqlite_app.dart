import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trananhtin_flutter_app/sqlite/page_home_sqlite.dart';
import 'package:trananhtin_flutter_app/sqlite/provider_data.dart';

class SQLiteApp extends StatefulWidget {
  const SQLiteApp({Key? key}) : super(key: key);

  @override
  State<SQLiteApp> createState() => _SQLiteAppState();
}

class _SQLiteAppState extends State<SQLiteApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        var databaseProvider = DatabaseProvider();
        databaseProvider.readUsers();
        return databaseProvider;
      },
      child: PageListUserSQLite(),
    );
  }
}