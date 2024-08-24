import 'package:admin_app/core/class/crud.dart';
import 'package:admin_app/linkapi.dart';


class OrdersPendingData {
  Crud crud;
  OrdersPendingData(this.crud);
  // getData() async {
  //   var response = await crud.postData(AppLink.viewPendingOrders, {});
  //   return response.fold((l) => l, (r) => r);
  // }

  Future<Map<String, dynamic>> getData() async {
    var response = await crud.getData(AppLink.viewpendingOrders);
    return response.fold((l) =>  throw l, (r) => r);
  }

  approveOrder(int orderid) async {
    var response = await crud.postData(
        AppLink.approveOrder, {"orderid": orderid});
    return response.fold((l) => l, (r) => r);
  }

  donePrepare(int orderid, int ordertype) async {
    var response = await crud
        .postData(AppLink.prepare, {"orderid": orderid, "ordertype": ordertype});
    return response.fold((l) => l, (r) => r);
  }
}
