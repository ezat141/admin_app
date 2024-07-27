import 'dart:io';
import 'package:admin_app/controller/orders/screen_controller.dart';
import 'package:admin_app/core/constant/color.dart';
import 'package:admin_app/view/widget/orders/custombottomappbarhome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OrderScreenControllerImp());
    return GetBuilder<OrderScreenControllerImp>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: const Text("Orders"),
              ),
              bottomNavigationBar: const CustomBottomAppBarHome(),
              body: PopScope(
                  child: controller.listPage.elementAt(controller.currentpage),
                  onPopInvoked: (shouldPop) async {
                    await Get.defaultDialog(
                      title: "warning",
                      titleStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor),
                      middleText: "Are you sure you want to exit?",
                      onCancel: () {},
                      cancelTextColor: AppColor.secondColor,
                      confirmTextColor: AppColor.secondColor,
                      buttonColor: AppColor.thirdColor,
                      onConfirm: () {
                        exit(0);
                      },
                    );
                    shouldPop = false;
                  }),
            ));
  }
}
