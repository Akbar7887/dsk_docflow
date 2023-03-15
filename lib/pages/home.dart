import 'package:dsk_docflow/controllers/Controller.dart';
import 'package:dsk_docflow/pages/catalogs/Warehouse_page.dart';
import 'package:dsk_docflow/pages/catalogs/personal_page.dart';
import 'package:dsk_docflow/pages/organization_page.dart';
import 'package:dsk_docflow/widgets/dskAppBar.dart';
import 'package:dsk_docflow/widgets/dskDrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../generated/l10n.dart';
import '../widgets/header.dart';
import 'order_page.dart';

final Controller _controller = Get.find();
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showDrawer = true;


  @override
  Widget build(BuildContext context) {

    return Obx(() => Scaffold(
        appBar: DskAppBar(), // extendBodyBehindAppBar: true,
        body:  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              showDrawer ? Expanded(child: DskDrawer()) : Container(),
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () {
                                setState(() {
                                  showDrawer = !showDrawer;
                                });
                              },
                            ),
                            Header(selectPageName()),

                          ],
                        ),
                      ),
                      Expanded(child: selectPage())
                    ],
                  ))
            ],
          ),
        )));
  }

  selectPage() {
    switch (_controller.page.value) {
      // case 0:
      //   {
      //     return OrganizationPage();
      //   }
      //   break;
      case 1:
        {
          return WarehousePage("warehouse");
        }
        break;
      case 2:
        {
          return WarehousePage("department");
        }
        break;
      case 3:
        {
          return WarehousePage("position");
        }
        break;
      case 4:
        {
          return PersonalPage();
        }
        break;
      // case 5:
      //   {
      //     return OrderPage();
      //   }
      //   break;
      default:
        {
          return Container();
        }
    }
  }

  String selectPageName() {
    switch (_controller.page.value) {
      // case 0:
      //   {
      //     return S.of(context).organization;
      //   }
      //   break;
      case 1:
        {
          return S.of(context).warehouse;
        }
        break;
      case 2:
        {
          return S.of(context).department;
        }
        break;
      case 3:
        {
          return S.of(context).position;
        }
        break;
      case 4:
        {
          return S.of(context).personal;
        }
        break;
      // case 5:
      //   {
      //     return S.of(context).order;
      //   }
      //   break;
      default:
        {
          return "";
        }
    }
  }
}
