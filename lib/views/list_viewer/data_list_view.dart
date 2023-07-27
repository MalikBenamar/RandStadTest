import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:simpson_character_viewer/Common/string_constants.dart';
import 'package:simpson_character_viewer/controllers/data_list_view_controller.dart';
import 'package:simpson_character_viewer/views/data_viewer/data_viewer.dart';

class DataListViewer extends StatelessWidget {
  DataListViewer({super.key, required this.isTablette});
  bool isTablette;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DataListViewerController());

    return Obx(() => Scaffold(
          appBar: AppBar(
            title: !controller.searchfocus.value
                ? Text(
                    appTitle.tr,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )
                : TextField(
                    onChanged: (value) => controller.SearchCharacters(value),
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Search for a character...".tr,
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[300])),
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                  ),
            actions: [
              !controller.searchfocus.value
                  ? IconButton(
                      onPressed: () {
                        controller.searchfocus.value = true;
                      },
                      icon: Icon(Icons.search))
                  : IconButton(
                      onPressed: () {
                        controller.currentCharacters.value =
                            controller.characters.value;
                        controller.searchfocus.value = false;
                      },
                      icon: Icon(Icons.close)),
            ],
          ),
          body: controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : controller.characters.isEmpty
                  ? Center(
                      child: Text("No Data"),
                    )
                  : Container(
                      height: Get.height,
                      child: ListView.builder(
                        itemCount: controller.currentCharacters.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              controller.selectedModel.value =
                                  controller.currentCharacters[index];

                              if (!isTablette) Get.to(() => DataViewer());
                            },
                            title: Text(controller
                                .currentCharacters[index].text!
                                .substring(
                                    0,
                                    controller.currentCharacters[index].text!
                                        .indexOf('-'))),
                            trailing: Icon(Icons.arrow_forward_ios, size: 16),
                          );
                        },
                      ),
                    ),
        ));
  }
}
