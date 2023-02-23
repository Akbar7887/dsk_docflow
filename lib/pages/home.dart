import 'package:dsk_docflow/controllers/Controller.dart';
import 'package:dsk_docflow/pages/Warehouse_page.dart';

import 'package:dsk_docflow/widgets/dskappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../models/UiC.dart';
import '../widgets/navigation_drawer.dart';
import 'order_page.dart';

class Home extends GetView<Controller> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DskAppBar(), // extendBodyBehindAppBar: true,
        body: Column(
          children: [
            Container(
              child: ElevatedButton(
                onPressed: () {
                  // setState(() {
                  Get.to(() => WarehousePage("department"));
                  // });

                  // Navigator.pop(context);
                },
                child: Text("DEp"),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  // setState(() {
                  Get.to(WarehousePage("position"));
                  // });
                  // Navigator.pop(context);
                },
                child: Text("Pos"),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  // setState(() {
                  Get.to(() => WarehousePage("warehouse"));
                  // });
                  // Navigator.pop(context);
                },
                child: Text("War"),
              ),
            )
          ],
        ),
        drawer: DskNavigationDrawer());
  }
}
