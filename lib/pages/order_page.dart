import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/dskappbar.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

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
        ],
      ),
    );
  }
}
