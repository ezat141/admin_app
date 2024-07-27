import 'dart:io';
import 'package:admin_app/controller/categories/view_controller.dart';
import 'package:admin_app/core/class/statusrequest.dart';
import 'package:admin_app/core/constant/routes.dart';
import 'package:admin_app/core/errors/failures.dart';
import 'package:admin_app/core/functions/handlingdatacontroller.dart';
import 'package:admin_app/core/functions/uploadfile.dart';
import 'package:admin_app/data/datasource/remote/categories_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesAddController extends GetxController {
  CategoriesData categoriesData = CategoriesData(Get.find());
  

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController namear;
  File? file;

  StatusRequest statusRequest = StatusRequest.none;

  Future<void> chooseImage() async {
    file = await fileUploadGallery(true);
    if (file != null) {
      print('Image selected: ${file!.path}');
    } else {
      print('No image selected.');
    }
    update();
  }

  Future<void> addData() async {
    if (formState.currentState!.validate()) {
      if (name.text.isEmpty || namear.text.isEmpty || file == null) {
        Get.snackbar("Warning", "Please choose an image");
        statusRequest = StatusRequest.failure;
        update();
        return;
      }

      statusRequest = StatusRequest.loading;
      update();

      try {
        String imageUrl = await categoriesData.uploadFileToCloudinary(file!);

        Map<String, dynamic> data = {
          "category_name": name.text,
          "category_name_ar": namear.text,
          "image": imageUrl,
        };

        print('Data to be sent to backend: $data'); // Print the data

        Either<Failure, Map<String, dynamic>> response = await categoriesData.add(data);
        print("=============================== Controller $response ");
        statusRequest = handlingData(response);
        response.fold(
          (failure) {
            statusRequest = StatusRequest.failure;
            print("Add Data Failure: ${failure.errMessage}");
            Get.snackbar("Error", failure.errMessage);
          },
          (responseBody) {
            if (responseBody['status'] == "success") {
              print("Add Data Success: ${responseBody['message']}");
              Get.offNamed(AppRoute.categoriesview);
              CategoriesController c = Get.find();
              c.getData();
            } else {
              statusRequest = StatusRequest.failure;
              print("Add Data Server Error: ${responseBody['message']}");
              Get.snackbar("Error", responseBody['message']);
            }
          },
        );
      } catch (e) {
        statusRequest = StatusRequest.failure;
        print("Add Data Failure: $e");
        Get.snackbar("Error", "Failed to upload image");
      }
      update();
    }
  }

//////////////// last ////////////////
//   Future<void> addData() async {
//   if (formState.currentState!.validate()) {
//     if (name.text.isEmpty || namear.text.isEmpty || file == null) {
//       Get.snackbar("Warning", "Please choose Image SVG");
//       statusRequest = StatusRequest.failure;
//       update();
//       return;
//     }
//     statusRequest = StatusRequest.loading;
//     update();
//     Map<String, dynamic> data = {
//       "category_name": name.text,
//       "category_name_ar": namear.text
//     };
//     Either<Failure, Map<String, dynamic>> response = await categoriesData.add(data, file!);
//     print("=============================== Controller $response ");
//     statusRequest = handlingData(response);
//     response.fold(
//       (failure) {
//         statusRequest = StatusRequest.failure;
//          print("Add Data Failure: ${failure.errMessage}"); // Log the error message
//          Get.snackbar("Error", failure.errMessage); // Display the error message to the user
//       },
//       (responseBody) {
//         if (responseBody['status'] == "success") {
//           Get.offNamed(AppRoute.categoriesview);
//           CategoriesController c = Get.find();
//           c.getData();
//         } else {
//           statusRequest = StatusRequest.failure;
          
//         }
//       },
//     );
//     update();
//   }
// }


  // addData() async {
  //   if (formState.currentState!.validate()) {
  //     if (name.text.isEmpty || namear.text.isEmpty || file == null) {
  //       Get.snackbar("Warnning", "Please choose Image SVG");
  //       statusRequest = StatusRequest.failure;
  //       return;
  //     }
  //     statusRequest = StatusRequest.loading;
  //     update();
  //     Map<String, dynamic> data = {
  //       "category_name": name.text,
  //       "category_name_ar": namear.text
  //     };
  //     var response = await categoriesData.add(data, file!);
  //     print("=============================== Controller $response ");
  //     statusRequest = handlingData(response);
  //     if (StatusRequest.success == statusRequest) {
  //       if (response['status'] == "success") {
  //         Get.offNamed(AppRoute.categoriesview);
  //         CategoriesController c = Get.find();
  //         c.getData();
  //       } else {
  //         statusRequest = StatusRequest.failure;
  //       }
  //     }
  //     update();
  //   }
  // }

  @override
  void onInit() {
    name = TextEditingController();
    namear = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    name.dispose();
    namear.dispose();
    super.onClose();
  }
}
