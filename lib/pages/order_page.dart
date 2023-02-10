import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/dskappbar.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DskAppBar(), // extendBodyBehindAppBar: true,
        body: Container());
  }
}
