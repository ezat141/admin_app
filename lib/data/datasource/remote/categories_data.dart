import 'dart:io';

import 'package:admin_app/core/class/crud.dart';
import 'package:admin_app/core/errors/failures.dart';
import 'package:admin_app/linkapi.dart';
import 'package:dartz/dartz.dart';

class CategoriesData {
  Crud crud;

  CategoriesData(this.crud);

  Future<Either<Failure, Map<String, dynamic>>> get() async {
    return await crud.getData(AppLink.categoriesview);
  }
  // Future<Map<String, dynamic>> get() async {
  //   var response = await crud.getData(AppLink.categoriesview);
  //   return response.fold((l) =>  throw l, (r) => r);
  // }

  // add(Map<String, dynamic> data, File file) async {
  //   var response = await crud.addRequestWithImageOne(AppLink.categoriesadd, data, file);
  //   return response.fold((l) => l, (r) => r);
  // }
  Future<Either<Failure, Map<String, dynamic>>> add(
      Map<String, dynamic> data) async {
    return await crud.postData(AppLink.categoriesadd, data);
  }

  Future<String> uploadFileToCloudinary(File file) async {
    return await crud.uploadFileToCloudinary(file);
  }

  Future<Either<Failure, Map<String, dynamic>>> edit(Map<String, dynamic> data) async {
    return await crud.putData(AppLink.categoriesedit, data);
  }

  delete(String id) async {
    var response = await crud.deleteData(AppLink.categoriesdelete, {'id': id});
    return response.fold((l) => l, (r) => r);
  }
}
