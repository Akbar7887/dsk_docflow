import 'package:dsk_docflow/models/UiC.dart';
import 'package:dsk_docflow/pages/Warehouse_page.dart';

import 'package:dsk_docflow/pages/home.dart';
import 'package:dsk_docflow/pages/order_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'controllers/Controller.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: UiC.companyName,
      theme: ThemeData(
        backgroundColor: Colors.black,
        bottomAppBarColor: Colors.black,
        textTheme: TextTheme(),
        fontFamily: UiC.font,
        // textTheme: TextTheme(bodyText1: ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //primarySwatch: Colors.black87,
      ),
      initialRoute: '/',
      initialBinding: HomeBindings(),
      unknownRoute: GetPage(name: '/notfound', page: () => Container()),
      getPages: [
        GetPage(name: '/', page: () => Home()),
        GetPage(name: '/department', page: () => WarehousePage("department")),
        GetPage(name: '/position', page: () => WarehousePage("position")),
        GetPage(name: '/warehouse', page: () => WarehousePage("warehouse")),
        GetPage(name: "/order", page: () => OrderPage())
        // GetPage(name: '/kompleksdetails', page: () => KompleksDetailesPage()),
      ],
    );
  }
}
