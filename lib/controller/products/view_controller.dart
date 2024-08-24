import 'package:admin_app/core/class/statusrequest.dart';
import 'package:admin_app/core/constant/routes.dart';
import 'package:admin_app/core/errors/failures.dart';
import 'package:admin_app/core/functions/handlingdatacontroller.dart';
import 'package:admin_app/data/datasource/remote/products_data.dart';
import 'package:admin_app/data/model/productsmodel.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  ProductsData productsData = ProductsData(Get.find());
  List<ProductsModel> data = [];

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

    Either<Failure, Map<String, dynamic>> response = await productsData.get();
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
          data.addAll(dataList.map((e) => ProductsModel.fromJson(e)));
          statusRequest = StatusRequest.success;
        } else {
          statusRequest = StatusRequest.failure;
        }
      },
    );

    update();
  }

  deleteProduct(String id) {
    productsData.delete(id);
    data.removeWhere((element) => element.sId == id);
    update();
  }

  goToPageEdit(ProductsModel productsModel) {
    Get.toNamed(AppRoute.productsedit,
        arguments: {"productsModel": productsModel});
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<bool> myback() async {
    Get.offAllNamed(AppRoute.homepage);

    return Future.value(false);
  }
}
