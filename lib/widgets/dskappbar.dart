import 'package:dsk_docflow/models/UiC.dart';
import 'package:dsk_docflow/pages/department_page.dart';
import 'package:dsk_docflow/pages/order_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
        TextButton(
            onPressed: () {
              Get.to(OrderPage());
            },
            child: Text(
              "ЗАКАЗЫ",
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
        TextButton(
            onPressed: () {
              Get.to(DepartmentPage());
            },
            child: Text(
              "ДЕПАРТАМЕНТЫ",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ))
      ],

      title: Text(
        UiC.companyName,
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
