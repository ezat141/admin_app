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
              CardAdminHome(url: AppImageAsset.avatar, title: "categories", onClick: (){
                Get.toNamed(AppRoute.categoriesview);
                
              }),
              CardAdminHome(url: AppImageAsset.avatar, title: "Products", onClick: (){
                Get.toNamed(AppRoute.productsview);
                
              }),
              CardAdminHome(url: AppImageAsset.avatar, title: "Orders", onClick: (){
                Get.toNamed(AppRoute.ordershome);
                
              }),
              CardAdminHome(url: AppImageAsset.avatar, title: "Message", onClick: (){
                
              }),
            ],
          )
        ],
      ),
    );
  }
}
