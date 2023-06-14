import 'package:flutter/cupertino.dart';
import 'package:registro_lotes_app/acre.dart';
import 'package:registro_lotes_app/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersState with ChangeNotifier {
  late User _user;
  List<Acre> _acres = [];

  UsersState() {
    // Initialize the user with default values
    _user = User(
        name: 'John Doe',
        email: 'john.doe@example.com',
        phoneNumber: '123-456-7890',
        createdAcres: _acres.length);
  }

  User get user => _user;

  set user(User user) {
    _user = user;
    notifyListeners();
  }

  void saveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _user.name);
    prefs.setString('email', _user.email);
    prefs.setString('phoneNumber', _user.phoneNumber);
    prefs.setInt('createdAcres', _acres.length);
  }

  void editUser(String name, String email, String phoneNumber) {
    _user.name = name;
    _user.email = email;
    _user.phoneNumber = phoneNumber;
    notifyListeners();
    saveUser();
  }

// Rest of the code for managing the acres list...
}
