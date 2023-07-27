import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:simpson_character_viewer/controllers/data_list_view_controller.dart';
import 'package:simpson_character_viewer/data/Models/CharacterModel.dart';

class DataViewer extends StatelessWidget {
  DataViewer({super.key});
  DataListViewerController controller = Get.find();
  Widget build(BuildContext context) {
    return Obx(
      () => controller.selectedModel.value != null
          ? Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: Get.height * 0.5,
                      width: Get.width,
                      child: CachedNetworkImage(
                        imageUrl:
                            "${controller.selectedModel.value!.firstURL}${controller.selectedModel.value!.icon}",
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/noImage.jpg',
                          fit: BoxFit.fill,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Get.size.width * 0.05,
                          top: Get.size.height * 0.02),
                      width: Get.size.width * 0.8,
                      height: Get.size.height * 0.1,
                      child: Text(
                        controller.selectedModel.value!.text!.substring(0,
                            controller.selectedModel.value!.text!.indexOf('-')),
                        style: TextStyle(
                            fontSize: Get.size.aspectRatio * 40,
                            color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: Get.height * 0.02,
                        left: Get.width * 0.05,
                      ),
                      child: Text(
                        "Description :",
                        style: TextStyle(fontSize: Get.size.aspectRatio * 30),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Get.height * 0.02,
                          bottom: Get.height * 0.02,
                          left: Get.width * 0.05,
                          right: Get.width * 0.03),
                      child: Text(
                        controller.selectedModel.value!.text!,
                        style: TextStyle(fontSize: Get.size.aspectRatio * 24),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Scaffold(
              body: Center(
                child: Text("Please select a character"),
              ),
            ),
    );
  }
}
