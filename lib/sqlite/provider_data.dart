import 'package:flutter/material.dart';
import 'package:trananhtin_flutter_app/sqlite/sqlite_data.dart';

class DatabaseProvider extends ChangeNotifier{
  DatabaseHelper? databaseHelper;
  List<User>? _users;
  bool _isLoading = false;

  DatabaseProvider(){
    databaseHelper = DatabaseHelper();
  }

  List<User>? get users => _users;
  bool get isLoading => _isLoading;

  Future<void> readUsers() async {
    if (_users == null) {
      _isLoading = true;
      notifyListeners();
      try {
        await databaseHelper!.open();
        _users = await databaseHelper!.getUsers();
      } catch (e) {
        _users = [];
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<int> updateUser(User user, int id) async{
    int count = await databaseHelper!.update(user, id);
    _users = await databaseHelper!.getUsers();
    notifyListeners();
    return count;
  }

  Future<int> insertUser(User user) async {
    int id = await databaseHelper!.insert(user);
    _users = await databaseHelper!.getUsers();
    notifyListeners();
    return id;
  }

  Future<int> deleteUser(int id) async{
    int count = await databaseHelper!.delete(id);
    _users = await databaseHelper!.getUsers();
    notifyListeners();
    return count;
  }

  void closeDatabase(){
    databaseHelper!.closeDatabase();
  }
}