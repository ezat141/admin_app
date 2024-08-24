import 'package:admin_app/controller/categories/edit_controller.dart';
import 'package:admin_app/core/class/handlingdataview.dart';
import 'package:admin_app/core/constant/color.dart';
import 'package:admin_app/core/functions/validinput.dart';
import 'package:admin_app/core/shared/customtextformglobal.dart';
import 'package:admin_app/view/widget/language/custombuttomlang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoriesEdit extends StatelessWidget {
  const CategoriesEdit({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CategoriesEditController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Categories"),
      ),
      body: GetBuilder<CategoriesEditController>(
        builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: controller.formState,
                  child: ListView(
                    children: [
                      CustomTextFormGlobal(
                          hinttext: "category name",
                          labeltext: "Category Name",
                          iconData: Icons.category,
                          mycontroller: controller.name,
                          valid: (val) {
                            return validInput(val!, 1, 30, "");
                          },
                          isNumber: false),
                      CustomTextFormGlobal(
                          hinttext: "category name (arabic)",
                          labeltext: "Category Name (arabic)",
                          iconData: Icons.category,
                          mycontroller: controller.namear,
                          valid: (val) {
                            return validInput(val!, 1, 30, "");
                          },
                          isNumber: false),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: MaterialButton(
                            onPressed: () {
                              controller.chooseImage();
                            },
                            color: AppColor.thirdColor,
                            textColor: AppColor.secondColor,
                            child: const Text("Choose category image"),
                          )),
                      if (controller.file != null)
                        SvgPicture.file(controller.file!, height: 80,),
                      CustomButtonLang(
                          textbutton: 'Save',
                          onPressed: () {
                            controller.editData();
                          })
                    ],
                  ),
                ))),
      ),
    );
  }
}
