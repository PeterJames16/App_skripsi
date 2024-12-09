import 'package:dltest/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dltest/models/user_model.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final _userRepo = Get.put(UserRepository());
    Future<List<UserModel>> getAllUser() async{

    return await _userRepo.allUser();
  }  
}