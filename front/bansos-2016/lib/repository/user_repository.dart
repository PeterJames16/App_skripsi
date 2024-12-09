import 'dart:convert';
import 'package:dltest/function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dltest/models/user_model.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://backend-service-286757499785.asia-southeast2.run.app';

class BaseClient{
  var client = http.Client();
  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(baseUrl+api+"?query="+object);
    var response = await http.post(url);
    print(url);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      //throw error here
    }
  }

  
}

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  String url = '';
  var data;

  createUser(UserModel user) async{
    try{
    DocumentReference docRef = await _db.collection("predictions").add(user.toJson());
    print(docRef.id);
    var response = await BaseClient().post("/api",docRef.id).catchError((err){});
    
    if(response == null ) {
      return ;
    }

    print(data);
    await _db.collection("predictions").doc(docRef.id).update({"hasil": response.body});
    }catch(e){

    return '$e';
    }

  }

    deleteUser(String docRef) async{
    try{

    var response = await BaseClient().post("/delete",docRef).catchError((err){});
    
    if(response == null ) {
      return ;
    }

    print(data);
    }catch(e){

    return '$e';
    }

  }



  Future<List<UserModel>> allUser() async{
    final snapshot = await _db.collection("predictions").get();
    final userData = snapshot.docs.map((e)=>UserModel.fromSnapshot(e)).toList();

    return userData;
  }
}