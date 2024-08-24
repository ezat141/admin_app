import 'dart:io';
import 'package:admin_app/controller/products/view_controller.dart';
import 'package:admin_app/core/class/statusrequest.dart';
import 'package:admin_app/core/constant/routes.dart';
import 'package:admin_app/core/errors/failures.dart';
import 'package:admin_app/core/functions/handlingdatacontroller.dart';
import 'package:admin_app/core/functions/uploadfile.dart';
import 'package:admin_app/data/datasource/remote/categories_data.dart';
import 'package:admin_app/data/datasource/remote/products_data.dart';
import 'package:admin_app/data/model/categoryModel.dart';
import 'package:dartz/dartz.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsAddController extends GetxController {
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

  StatusRequest statusRequest = StatusRequest.none;


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
        String imageUrl = await productsData.uploadFileToCloudinary(file!);

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
        };

        print('Data to be sent to backend: $data'); // Print the data

        Either<Failure, Map<String, dynamic>> response = await productsData.add(data);
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
              Get.offNamed(AppRoute.productsview);
              ProductsController c = Get.find();
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

  getCategorioes() async{
    CategoriesData categoriesData = CategoriesData(Get.find());

    statusRequest = StatusRequest.loading;
    update();

    Either<Failure, Map<String, dynamic>> response = await categoriesData.get();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        print(failure.errMessage); // Log the error message
      },
      (responseBody) {
        if (responseBody['status'] == "success") {
          List<CategoryModel> data = [];
          List dataList = responseBody['data'];
          data.addAll(dataList.map((e) => CategoryModel.fromJson(e)));

          for(int i=0; i<data.length; i++){
            drowdownlist.add(SelectedListItem(name: data[i].categoryName!, value: data[i].sId ));


          }
          statusRequest = StatusRequest.success;
        } else {
          statusRequest = StatusRequest.failure;
        }
      },
  );

  update();

  }



  @override
  void onInit() {
    getCategorioes();
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
    





    super.onInit();
  }

  showDropDown(context){
    DropDownState(
      DropDown(
        bottomSheetTitle: const Text(
          "title",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data:  [SelectedListItem(name: 'Item 1'), SelectedListItem(name: 'Item 2'), SelectedListItem(name: 'Item 3')],
        onSelected: (List<dynamic> selectedList) {
          SelectedListItem selectedItem = selectedList[0];
          dropdownname.text = selectedItem.name;
          // dropdownid.text = selectedItem.id; // If you want to use id, uncomment this line
          // List<String> list = [];
          // for(var item in selectedList) {
          //   if(item is SelectedListItem) {
          //     list.add(item.name);
          //   }
          // }
          // showSnackBar(list.toString());
        },
        // enableMultipleSelection: true,
      ),
    ).showModal(context);
  }

  @override
  void onClose() {
    name.dispose();
    namear.dispose();
    super.onClose();
  }
}
