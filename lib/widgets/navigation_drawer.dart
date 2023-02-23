import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../models/UiC.dart';
import '../pages/Warehouse_page.dart';

List<String> listdrop = ['Руководство', 'Новости', 'Вакансии'];
bool _showmenu = false;

class DskNavigationDrawer extends StatelessWidget {
  const DskNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              _showmenu = !_showmenu;
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
                        Get.toNamed("/department");

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
                        Get.to(WarehousePage("position"));

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
                        print("wer");
                        Get.to(() => WarehousePage("warehouse"));
                        Navigator.pop(context);
                      },
                    ),
                    // Divider()
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
