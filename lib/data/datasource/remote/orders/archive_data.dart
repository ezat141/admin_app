import 'package:admin_app/core/class/crud.dart';
import 'package:admin_app/linkapi.dart';


class OrdersArchiveData {
  Crud crud;
  OrdersArchiveData(this.crud);
  getData(String deliveryid) async {
    var response = await crud.postData(AppLink.viewArchivedOrders, {"deliveryid": deliveryid});
    return response.fold((l) => l, (r) => r);
  }

}
