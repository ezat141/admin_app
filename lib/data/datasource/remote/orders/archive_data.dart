import 'package:admin_app/core/class/crud.dart';
import 'package:admin_app/linkapi.dart';


class OrdersArchiveData {
  Crud crud;
  OrdersArchiveData(this.crud);
  getData() async {
    var response = await crud.getData(AppLink.viewarchiveOrder);
    return response.fold((l) => l, (r) => r);
  }

}
