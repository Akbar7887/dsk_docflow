import 'package:dsk_docflow/models/UiConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      leading: Padding(
          padding: EdgeInsets.only(left: 100),
          child: Row(
            children: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "ЗАКАЗЫ",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ))
            ],
          )),
      title: Text(
        UiConstant.companyName,
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
