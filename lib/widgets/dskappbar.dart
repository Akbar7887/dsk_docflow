import 'package:dsk_docflow/controllers/Controller.dart';
import 'package:dsk_docflow/models/UiC.dart';
import 'package:dsk_docflow/pages/Warehouse_page.dart';
import 'package:dsk_docflow/pages/order_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// enum Menu { Department, Menegers, News, Vacansy }

Controller _controller = Get.put(Controller());
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
        SizedBox(
          width: 20,
        ),
        // Padding(
        //     padding: EdgeInsets.only(right: 20.0),
        //     child: GestureDetector(
        //       onTap: () {
        //         Get.toNamed('/department');
        //       },
        //       child: Icon(Icons.more_vert),
        //     )),
        Container(
            alignment: Alignment.center,
            child: PopupMenuButton(
                position: PopupMenuPosition.under,
                elevation: 5,
                offset: const Offset(0, 30),
                child: Text(
                  "Справочники",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onSelected: (menuitem) {
                  print(menuitem);
                },
                itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child: GestureDetector(
                          onTap: () => Get.toNamed('/department'),
                          child: Text(
                            "Департаменты",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        value: 0,
                      ),
                      PopupMenuItem(
                          child: GestureDetector(
                        onTap: () => Get.toNamed('/position'),
                        child: Text(
                          "Должности",
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
                      PopupMenuItem(
                        child: GestureDetector(
                            onTap: () {
                              Get.toNamed('/warehouse');
                            },
                            child: Text(
                              "Склады",
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                    ]))
      ],

      title: Text(
        UiC.companyName,
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
