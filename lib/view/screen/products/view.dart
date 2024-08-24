import 'package:admin_app/controller/products/view_controller.dart';
import 'package:admin_app/core/class/handlingdataview.dart';
import 'package:admin_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import the package
import 'package:get/get.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductsController());
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoute.productsadd);
          },
          child: const Icon(Icons.add)),
      body: GetBuilder<ProductsController>(
          builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: PopScope(
                onPopInvoked: (isPopped) {
                  if (isPopped) {
                    controller.myback;
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: controller.data.length,
                    itemBuilder: ((context, index) => InkWell(
                      onTap: (){
                        controller.goToPageEdit(controller.data[index]);
                      },
                      child: Card(
                              child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    child: CachedNetworkImage(
                                      imageUrl: "${controller.data[index].image}",
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
                                        // }, icon: const Icon(Icons.edit)),
                      
                                        IconButton(
                                            onPressed: () {
                                              Get.defaultDialog(
                                                  title: "Warning",
                                                  middleText:
                                                      "Are you sure you want to delete this product ?",
                                                  onCancel: () {},
                                                  onConfirm: () {
                                                    controller.deleteProduct(
                                                        controller
                                                            .data[index].sId!);
                                                    Get.back();
                                                  });
                                            },
                                            icon:
                                                const Icon(Icons.delete_outline)),
                                      ],
                                    ),
                                    subtitle: Text(
                                        "${controller.data[index].productDate}"),
                                    title: Text(
                                        "${controller.data[index].productName}"),
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
