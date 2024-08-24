import 'dart:io';
import 'package:admin_app/controller/products/view_controller.dart';
import 'package:admin_app/core/class/statusrequest.dart';
import 'package:admin_app/core/constant/routes.dart';
import 'package:admin_app/core/errors/failures.dart';
import 'package:admin_app/core/functions/handlingdatacontroller.dart';
import 'package:admin_app/core/functions/uploadfile.dart';
import 'package:admin_app/data/datasource/remote/products_data.dart';
import 'package:admin_app/data/model/productsmodel.dart';
import 'package:dartz/dartz.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsEditController extends GetxController {
  ProductsData productsData = ProductsData(Get.find());

  List<SelectedListItem> drowdownlist = [];

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late TextEditingController dropdownname;
  late TextEditingController dropdownid;
  late TextEditingController name;
  late TextEditingController namear;
  late TextEditingController description;
  late TextEditingController descriptionar;
  late TextEditingController count;
  late TextEditingController price;
  late TextEditingController discount;
  TextEditingController? catname;

  TextEditingController? catid;
  File? file;
  bool? active ;
  late ProductsModel productsModel;

  StatusRequest statusRequest = StatusRequest.none;

  changeStatusActive(val){
    active = val;

    update();

  }

  // chooseImage() async{
  //   file = await fileUploadGallery(true);
  //   update();
  // }

  showOptionImage() {
    showbottommenu(chooseImageGallery, chooseImageCamera);
  }

  Future<void> chooseImageCamera() async {
    file = await imageUploadCamera();
    if (file != null) {
      print('Image selected: ${file!.path}');
    } else {
      print('No image selected.');
    }

    update();
  }
  Future<void> chooseImageGallery() async {
    file = await fileUploadGallery(false);
    if (file != null) {
      print('Image selected: ${file!.path}');
    } else {
      print('No image selected.');
    }
    update();
  }


  editData() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
    
      try {
        // Initialize imageUrl with the existing image URL from the categoryModel
        String? imageUrl = productsModel.image;

        // Check if a new file has been selected
        if (file != null) {
          imageUrl = await productsData.uploadFileToCloudinary(file!);
        }

        Map<String, dynamic> data = {
          "product_name": name.text,
          "product_name_ar": namear.text,
          "product_desc": description.text,
          "product_desc_ar": descriptionar.text,
          "product_count": count.text,
          "product_price": price.text,
          "product_discount": discount.text,
          "product_cat": catid!.text, 
          "image": imageUrl,
          "product_active": active,
          "id": productsModel.sId.toString()
        };
      Either<Failure, Map<String, dynamic>> response = await productsData.edit(data);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      response.fold(
        (failure) {
          statusRequest = StatusRequest.failure;
          print("Edit Data Failure: ${failure.errMessage}"); // Log the error message
        },
        (responseBody) {
          if (responseBody['status'] == "success") {
            Get.offNamed(AppRoute.productsview);
            ProductsController c = Get.find();
            c.getData();
          } else {
            statusRequest = StatusRequest.failure;
            print("Edit Data Server Error: ${responseBody['message']}");
            Get.snackbar("Error", responseBody['message']); // Log server error message
          }
        },
      );
    } catch (e) {
        statusRequest = StatusRequest.failure;
        print("Edit Data Failure: $e");
        Get.snackbar("Error", "Failed to upload image");
      }
      update();
    }
  }

  

  @override
  void onInit() {
    productsModel = Get.arguments['productsModel'];
    dropdownname = TextEditingController();
    dropdownid = TextEditingController();
    name = TextEditingController();
    namear = TextEditingController();
    
    description = TextEditingController();
    descriptionar = TextEditingController();
    
    count = TextEditingController();
    
    price = TextEditingController();
    
    discount = TextEditingController();
    
    catname = TextEditingController();
    
    catid = TextEditingController();
    

    name.text = productsModel.productName!;
    namear.text = productsModel.productNameAr!;
    description.text = productsModel.productDesc!;
    descriptionar.text = productsModel.productDescAr!;
    count.text = productsModel.productCount.toString();
    price.text = productsModel.productPrice.toString();
    discount.text = productsModel.productDiscount.toString();
    active = productsModel.productActive;
    catname!.text = productsModel.categoryName!;
    catid!.text = productsModel.categoryId!;
    // Lazy initialization of CategoriesController
    // Get.lazyPut(() => ProductsController());

    super.onInit();
  }
}


