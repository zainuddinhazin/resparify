import 'package:flutter/material.dart';

import 'package:resparify5/models/user_model.dart';
import 'package:resparify5/services/auth_methods.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final AuthMethods _authMethods = AuthMethods();
  UserModel? get getUser => _user;
  Future<void> refreshUser() async {
    UserModel? user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
