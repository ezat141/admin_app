import 'package:admin_app/core/class/crud.dart';
import 'package:admin_app/linkapi.dart';


class OrdersAcceptedData {
  Crud crud;
  OrdersAcceptedData(this.crud);
  getData(int deliveryid) async {
    var response = await crud
        .postData(AppLink.viewAcceptedOrders, {"deliveryid": deliveryid});
    return response.fold((l) => l, (r) => r);
  }
  doneDelivery(int orderid) async {
    var response = await crud
        .postData(AppLink.doneDelivery, {"orderid": orderid});
    return response.fold((l) => l, (r) => r);
  }
}
