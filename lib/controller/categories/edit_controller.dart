import 'dart:io';
import 'package:admin_app/controller/categories/view_controller.dart';
import 'package:admin_app/core/class/statusrequest.dart';
import 'package:admin_app/core/constant/routes.dart';
import 'package:admin_app/core/errors/failures.dart';
import 'package:admin_app/core/functions/handlingdatacontroller.dart';
import 'package:admin_app/core/functions/uploadfile.dart';
import 'package:admin_app/data/datasource/remote/categories_data.dart';
import 'package:admin_app/data/model/categoryModel.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesEditController extends GetxController {
  CategoriesData categoriesData = CategoriesData(Get.find());

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController namear;
  late CategoryModel categoryModel;
  File? file;
  StatusRequest statusRequest = StatusRequest.none;

  chooseImage() async{
    file = await fileUploadGallery(true);
    update();
  }


  editData() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map<String, dynamic> data = {
        "category_name": name.text,
        "category_name_ar": namear.text,
        "id": categoryModel.sId.toString()
      };
      Either<Failure, Map<String, dynamic>> response = await categoriesData.edit(data, file);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      response.fold(
        (failure) {
          statusRequest = StatusRequest.failure;
          print("Edit Data Failure: ${failure.errMessage}"); // Log the error message
        },
        (responseBody) {
          if (responseBody['status'] == "success") {
            print("Edit Data Success: ${responseBody['message']}"); // Log success message
            Get.offNamed(AppRoute.categoriesview);
            CategoriesController c = Get.find();
            c.getData();
          } else {
            statusRequest = StatusRequest.failure;
            print("Edit Data Server Error: ${responseBody['message']}"); // Log server error message
          }
        },
      );
      update();
    }
  }

  // editData() async {

  //   if (formState.currentState!.validate()) {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   Map<String, dynamic> data= {
  //     "category_name": name.text,
  //     "category_name_ar": namear.text
  //   };
  //   var response = await categoriesData.edit(data, file);
  //   print("=============================== Controller $response ");
  //   statusRequest = handlingData(response);
  //   if (StatusRequest.success == statusRequest) {
  //     if (response['status'] == "success") {
  //       Get.offNamed(AppRoute.categoriesview);
  //       CategoriesController c =  Get.find();
  //       c.getData();
  //     } else {
  //       statusRequest = StatusRequest.failure ; 
  //     }
  //   }
  //   update();
  //   }
    
  // }

  @override
  void onInit() {
    categoryModel = Get.arguments['categoryModel'];
    name = TextEditingController();
    namear = TextEditingController();
    name.text = categoryModel.categoryName!;
    namear.text = categoryModel.categoryNameAr!;
    super.onInit();
  }
}


