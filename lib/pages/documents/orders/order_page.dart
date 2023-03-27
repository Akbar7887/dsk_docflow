import 'package:dsk_docflow/controllers/Controller.dart';
import 'package:dsk_docflow/models/UiC.dart';
import 'package:dsk_docflow/models/catalogs/Personal.dart';
import 'package:dsk_docflow/models/catalogs/Warehouse.dart';
import 'package:dsk_docflow/pages/documents/orders/orderItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../generated/l10n.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final Controller _controller = Get.find();
  late Personal _dropdownPersonal;
  late Warehouse _dropdownWarehouse;

  @override
  void initState() {
    _dropdownPersonal = _controller.personals.value.firstWhere(
        (element) => element.id == _controller.ordergood.value.worker!.id);
    _dropdownWarehouse = _controller.warehouses.value.firstWhere(
        (element) => element.id == _controller.ordergood.value.warehouse!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListView(children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: Text(
                      '${S.of(context).date}-${UiC.dateFormat.format(DateTime.parse(_controller.ordergood.value.datecreate!))}',
                    )),
                    SizedBox(
                      width: 100,
                    ),
                    Container(
                        child: Text(
                      '${S.of(context).recievedate}-${UiC.dateFormat.format(DateTime.parse(_controller.ordergood.value.recieveDate!))}',
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: Row(
                children: [
                  Container(
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Personal>(
                              hint: Text(S.of(context).personal),
                              value: _dropdownPersonal,
                              items: _controller.personals.value
                                  .map((element) => DropdownMenuItem(
                                        child: Text(element.name!),
                                        value: element,
                                      ))
                                  .toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _dropdownPersonal = newValue!;
                                });
                              },
                            ),
                          ))),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Warehouse>(
                              hint: Text(S.of(context).personal),
                              value: _dropdownWarehouse,
                              items: _controller.warehouses.value
                                  .map((element) => DropdownMenuItem(
                                        child: Text(element.name!),
                                        value: element,
                                      ))
                                  .toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _dropdownWarehouse = newValue!;
                                });
                              },
                            ),
                          ))),
                ],
              )),

              OrderItem()

            ])));
  }
}
