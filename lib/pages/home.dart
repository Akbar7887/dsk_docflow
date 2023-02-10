import 'package:dsk_docflow/widgets/dskappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DskAppBar(), // extendBodyBehindAppBar: true,
        body: Container());
  }
}
