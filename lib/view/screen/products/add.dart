import 'package:admin_app/controller/products/add_controller.dart';
import 'package:admin_app/core/class/handlingdataview.dart';
import 'package:admin_app/core/constant/color.dart';
import 'package:admin_app/core/functions/validinput.dart';
import 'package:admin_app/core/shared/customdropdownsearch.dart';
import 'package:admin_app/core/shared/customtextformglobal.dart';
import 'package:admin_app/view/widget/language/custombuttomlang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsAdd extends StatelessWidget {
  const ProductsAdd({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductsAddController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: GetBuilder<ProductsAddController>(
        builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: controller.formState,
                  child: ListView(
                    children: [
                      CustomTextFormGlobal(
                          hinttext: "product name",
                          labeltext: "Product Name",
                          iconData: Icons.category,
                          mycontroller: controller.name,
                          valid: (val) {
                            return validInput(val!, 1, 30, "");
                          },
                          isNumber: false),
                      CustomTextFormGlobal(
                          hinttext: "product name (arabic)",
                          labeltext: "Product Name (arabic)",
                          iconData: Icons.category,
                          mycontroller: controller.namear,
                          valid: (val) {
                            return validInput(val!, 1, 30, "");
                          },
                          isNumber: false),
                      CustomTextFormGlobal(
                          hinttext: "description name",
                          labeltext: "Description Name",
                          iconData: Icons.category,
                          mycontroller: controller.description,
                          valid: (val) {
                            return validInput(val!, 1, 100, "");
                          },
                          isNumber: false),
                      CustomTextFormGlobal(
                          hinttext: "description name (arabic)",
                          labeltext: "Description Name (arabic)",
                          iconData: Icons.category,
                          mycontroller: controller.descriptionar,
                          valid: (val) {
                            return validInput(val!, 1, 100, "");
                          },
                          isNumber: false),
                      CustomTextFormGlobal(
                          hinttext: "count",
                          labeltext: "Count",
                          iconData: Icons.category,
                          mycontroller: controller.count,
                          valid: (val) {
                            return validInput(val!, 1, 30, "");
                          },
                          isNumber: true),
                      CustomTextFormGlobal(
                          hinttext: "price",
                          labeltext: "Price",
                          iconData: Icons.category,
                          mycontroller: controller.price,
                          valid: (val) {
                            return validInput(val!, 1, 30, "");
                          },
                          isNumber: true),
                      CustomTextFormGlobal(
                          hinttext: "discount",
                          labeltext: "Discount",
                          iconData: Icons.category,
                          mycontroller: controller.discount,
                          valid: (val) {
                            return validInput(val!, 1, 30, "");
                          },
                          isNumber: true),
                          
                      CustomDropdownSearch(title: "Choose Category", listsata: controller.drowdownlist, dropdownSelectedName: controller.catname!, dropdownSelectedID: controller.catid!),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: MaterialButton(
                            onPressed: () {
                              controller.showOptionImage();
                            },
                            color: AppColor.thirdColor,
                            textColor: AppColor.secondColor,
                            child: const Text("Choose product image"),
                          )),
                      if (controller.file != null)
                        Image.file(
                          controller.file!,
                          height: 100,
                          width: 100,
                        ),
                      CustomButtonLang(
                          textbutton: 'Add',
                          onPressed: () {
                            controller.addData();
                          })
                    ],
                  ),
                ))),
      ),
    );
  }
}
