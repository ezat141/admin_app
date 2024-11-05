import 'package:admin_app/controller/home_controller.dart';
import 'package:admin_app/core/constant/image_asset.dart';
import 'package:admin_app/core/constant/routes.dart';
import 'package:admin_app/view/widget/home/cardadmin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeControllerImp controller = Get.put(HomeControllerImp());
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        children: [
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisExtent: 150),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              CardAdminHome(url: AppImageAsset.categories, title: "Categories", onClick: (){
                Get.toNamed(AppRoute.categoriesview);
                
              }),
              CardAdminHome(url: AppImageAsset.products, title: "Products", onClick: (){
                Get.toNamed(AppRoute.productsview);
                
              }),
              CardAdminHome(url: AppImageAsset.orders, title: "Orders", onClick: (){
                Get.toNamed(AppRoute.ordershome);
                
              }),
              CardAdminHome(url: AppImageAsset.reports, title: "Reports", onClick: (){
                
              }),
            ],
          )
        ],
      ),
    );
  }
}
