import 'package:admin_app/core/class/crud.dart';
import 'package:admin_app/linkapi.dart';


class OrdersAcceptedData {
  Crud crud;
  OrdersAcceptedData(this.crud);
  getData() async {
    var response = await crud
        .getData(AppLink.viewacceptedOrders);
    return response.fold((l) => l, (r) => r);
  }
  donePrepare(int orderid, int ordertype) async {
    var response = await crud
        .postData(AppLink.prepare, {"orderid": orderid, "ordertype": ordertype});
    return response.fold((l) => l, (r) => r);
  }
}
