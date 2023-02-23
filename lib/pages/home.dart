import 'package:dsk_docflow/pages/Warehouse_page.dart';
import 'package:dsk_docflow/pages/position_page.dart';
import 'package:dsk_docflow/widgets/dskappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../models/UiC.dart';
import 'department_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> listdrop = ['Руководство', 'Новости', 'Вакансии'];
  bool _showmenu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DskAppBar(), // extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Container(
            child: ElevatedButton(
              onPressed: () {
                Get.to(WarehousePage(data: "department"));
                Navigator.pop(context);
              },
              child: Text("DEp"),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                Get.to(WarehousePage(data: "position"));
                Navigator.pop(context);
              },
              child: Text("Pos"),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                Get.to(WarehousePage(data: "warehouse"));
                Navigator.pop(context);
              },
              child: Text("War"),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            DrawerHeader(
              child: FittedBox(
                child: Text(
                  UiC.companyName,
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
            Divider(),
            ListTile(
              leading: Text(
                'Справочники',
                style: TextStyle(
                    fontSize: 25, fontFamily: UiC.font, color: Colors.black),
              ),
              onTap: () {
                setState(() {
                  _showmenu = !_showmenu;
                });
                // controller.changeindexpage(1);
                // controller.changeindextab(1);
                // Navigator.pop(context);
              },
            ),
            _showmenu
                ? Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        child: SizedBox(
                            height: 50,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                Icon(
                                  Icons.arrow_right_sharp,
                                  // size: 50,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Департаменты',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: UiC.font,
                                      color: Colors.black),
                                ),
                              ],
                            )),
                        onTap: () {
                          Get.to(() => DepartmentPage());
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                      InkWell(
                        child: SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                Icon(
                                  Icons.arrow_right_sharp,
                                  // size: 50,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Должности',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: UiC.font,
                                      color: Colors.black),
                                ),
                              ],
                            )),
                        onTap: () {
                          Get.to(() => PositionPage());

                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                      InkWell(
                        child: SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                Icon(
                                  Icons.arrow_right_sharp,
                                  // size: 50,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Склады',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: UiC.font,
                                      color: Colors.black),
                                ),
                              ],
                            )),
                        onTap: () {
                          Get.to(() => WarehousePage(data: "warehouse"));

                          Navigator.pop(context);
                        },
                      ),
                      // Divider()
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
