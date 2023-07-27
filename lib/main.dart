import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:simpson_character_viewer/Common/string_constants.dart';
import 'package:simpson_character_viewer/controllers/data_list_view_controller.dart';
import 'package:simpson_character_viewer/views/data_viewer/data_viewer.dart';
import 'package:simpson_character_viewer/views/list_viewer/data_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  var controller = Get.put(DataListViewerController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WillPopScope(
          onWillPop: () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
            Navigator.of(context).pop();
            //we need to return a future
            return Future.value(false);
          },

          // child:   Phone
          child: ResponsiveScreen(),
        ));
  }
}

class ResponsiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check the screen size
    var isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    if (isTablet) {
      // On tablets, show list and detail on the same screen
      return Row(
        children: [
          Flexible(
              flex: 2,
              child: DataListViewer(
                isTablette: true,
              )),
          Flexible(flex: 4, child: DataViewer()),
        ],
      );
    } else {
      // On phones, show list and detail on separate screens
      return DataListViewer(
        isTablette: false,
      );
    }
  }
}
