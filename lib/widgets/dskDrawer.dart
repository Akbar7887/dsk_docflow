import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/Controller.dart';
import '../generated/l10n.dart';
import '../models/UiC.dart';

final Controller _controller = Get.find();

class DskDrawer extends StatelessWidget {
  const DskDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.black87,
        // scrollDirection: Axis.vertical,
        child: SafeArea(
            child: Column(
          children: [
            ListTile(
              title: Text(
                UiC.companyName,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            // ListTile(
            //   iconColor: Colors.white,
            //   leading: Icon(
            //     Icons.home,
            //     color: Colors.white,
            //   ),
            //   title: Text(
            //     S.of(context).organization,
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   onTap: () {
            //     _controller.page.value = 0;
            //   },
            // ),
            ExpansionTile(
              collapsedIconColor: Colors.white,
              controlAffinity: ListTileControlAffinity.platform,
              leading: Icon(
                Icons.view_agenda,
                color: Colors.white,
              ),
              title: Text(
                S.of(context).catalog,
                style: TextStyle(color: Colors.white),
              ),
              textColor: Colors.white,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.only(left: 80.0, right: 0.0),
                  iconColor: Colors.white,
                  title: Text(
                    S.of(context).warehouse,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _controller.page.value = 1;
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 80.0, right: 0.0),
                  title: Text(
                    S.of(context).department,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _controller.page.value = 2;
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 80.0, right: 0.0),
                  title: Text(
                    S.of(context).position,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _controller.page.value = 3;
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 80.0, right: 0.0),
                  title: Text(
                    S.of(context).personal,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _controller.page.value = 4;
                  },
                ),
              ],
            ),
            ExpansionTile(
              collapsedIconColor: Colors.white,
              controlAffinity: ListTileControlAffinity.platform,
              leading: Icon(
                Icons.view_agenda,
                color: Colors.white,
              ),
              title: Text(
                S.of(context).documents,
                style: TextStyle(color: Colors.white),
              ),
              textColor: Colors.white,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.only(left: 80.0, right: 0.0),
                  iconColor: Colors.white,
                  title: Text(
                    S.of(context).order,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _controller.page.value = 5;
                  },
                ),

              ],
            ),
          ],
        )));
  }
}
