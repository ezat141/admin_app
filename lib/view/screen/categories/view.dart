import 'package:admin_app/controller/categories/view_controller.dart';
import 'package:admin_app/core/class/handlingdataview.dart';
import 'package:admin_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CategoriesController());
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(AppRoute.categoriesadd);
      }, 
      child: const Icon(Icons.add)),
      body: GetBuilder<CategoriesController>(
        builder: (controller) => HandlingDataView(
          statusRequest: controller.statusRequest, 
          widget: PopScope(
            onPopInvoked: (isPopped) {
              if (isPopped){
                controller.myback;
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
            
                itemCount: controller.data.length,
                itemBuilder: ((context, index) =>
                    InkWell(
                      onTap: () {
                        controller.goToPageEdit(controller.data[index]);
                      } ,
                      child: Card(child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              child: SvgPicture.network(
                                "${controller.data[index].image}",
                                height: 80,
                              ),
                            )),
                          Expanded(
                            flex: 3,
                            child: ListTile(
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // IconButton(onPressed: (){
                                    
                                  //   controller.goToPageEdit(controller.data[index]);
                                  // }, icon: Icon(Icons.edit)),
                                  
                                  IconButton(onPressed: (){
                                    Get.defaultDialog(title: "Warning", middleText: "Are you sure you want to delete this category ?", onCancel: (){}, onConfirm: (){
                                    controller.deleteCategory(controller.data[index].sId!);
                                    Get.back();
                                    });
                                  }, icon: Icon(Icons.delete_outline)),
                                ],
                              ),
                              subtitle: Text("${controller.data[index].categoryDatetime}"),
                              title: Text("${controller.data[index].categoryName}"),
                            )),
                        ],
                      )),
                    )),
              ),
            
                    ),
          ))),

    );
  }
}