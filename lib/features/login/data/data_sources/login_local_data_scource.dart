import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/current_user_model.dart';

abstract class LoginLocalDataSource {

  Future<CurrentUserModel> getCurrentUser();
  Future<void> cacheCurrentUser(CurrentUserModel currentUserModel);
  Future<void> removeCacheCurrentUser();
}



class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({required this.sharedPreferences});


  @override
  Future<CurrentUserModel> getCurrentUser() {

    final jsonString =
    sharedPreferences.getString(AppStrings.cachedCurrentUser);
    if (jsonString != null) {
      final cacheCurrentUser =
      Future.value(CurrentUserModel.fromJson(json.decode(jsonString)));
      return cacheCurrentUser;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheCurrentUser(CurrentUserModel currentUserModel) {
    return sharedPreferences.setString(
        AppStrings.cachedCurrentUser, json.encode(currentUserModel));
  }

  @override
  Future<void> removeCacheCurrentUser() {
    return sharedPreferences.remove(AppStrings.cachedCurrentUser);
  }



}


