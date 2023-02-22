import 'package:dsk_docflow/models/UiC.dart';
import 'package:dsk_docflow/pages/department_page.dart';
import 'package:dsk_docflow/pages/order_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

enum Menu { Department, Menegers, News, Vacansy }

class DskAppBar extends StatelessWidget with PreferredSizeWidget {
  const DskAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Add AppBar here only
      backgroundColor: Colors.black,
      elevation: 0.0,
      actions: [
        Container(
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () {
                  Get.to(() => OrderPage());
                },
                child: Text(
                  "Заказы",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ))),
        SizedBox(width: 20,),
        Container(
            alignment: Alignment.center,
            child: PopupMenuButton<Menu>(
                position: PopupMenuPosition.under,
                elevation: 5,
                offset: const Offset(0, 30),
                child: Text(
                  "Справочники",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                      PopupMenuItem(
                        child: TextButton(
                            onPressed: () {
                              // Get.offAll(OrderPage());
                              Get.to(() => DepartmentPage());
                            },
                            child: Text(
                              "ДЕПАРТАМЕНТЫ",
                              style: TextStyle(fontSize: 20),
                            )),
                      )
                    ]))
      ],

      title: Text(
        UiC.companyName,
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
