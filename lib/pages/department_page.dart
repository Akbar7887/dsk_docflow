import 'package:dsk_docflow/controllers/Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/dskappbar.dart';

class DepartmentPage extends StatefulWidget {
  const DepartmentPage({Key? key}) : super(key: key);

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {

  final Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DskAppBar(), // extendBodyBehindAppBar: true,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
              width: 200,
              child: ElevatedButton(onPressed: () {}, child: Text("Добавить"))),
          SizedBox(
            height: 20,
          ),


        ],
      ),
    );
  }
}


