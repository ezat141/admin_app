
import 'package:admin_app/core/class/statusrequest.dart';
import 'package:admin_app/core/constant/routes.dart';
import 'package:admin_app/core/errors/failures.dart';
import 'package:admin_app/core/functions/handlingdatacontroller.dart';
import 'package:admin_app/data/datasource/remote/categories_data.dart';
import 'package:admin_app/data/model/categoryModel.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  CategoriesData categoriesData = CategoriesData(Get.find());
  List<CategoryModel> data = [];

  late StatusRequest statusRequest;

  // getData() async {

  //   data.clear();
  //   statusRequest = StatusRequest.loading;
  //   var response = await categoriesData.get();
  //   print("=============================== Controller $response ");
  //   statusRequest = handlingData(response);
  //   if (StatusRequest.success == statusRequest) {
  //     if (response['status'] == "success") {
  //       List dataList = response['data'];
  //       data.addAll(dataList.map((e) => CategoryModel.fromJson(e)));
  //     } else {
  //       statusRequest = StatusRequest.failure ; 
  //     }
  //   }
  //   update();
  // }

  getData() async {
  data.clear();
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
        List dataList = responseBody['data'];
        data.addAll(dataList.map((e) => CategoryModel.fromJson(e)));
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
      }
    },
  );

  update();
}


  deleteCategory(String id){
    categoriesData.delete(id);
    data.removeWhere((element) => element.sId == id);
    update();

  }
  goToPageEdit(CategoryModel categoryModel){
    Get.toNamed(AppRoute.categoriesedit, arguments: {
      "categoryModel": categoryModel
    });
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  // myback(){
  //   Get.offAllNamed(AppRoute.homepage);
  //   return Future.value(false);
  // }
}


