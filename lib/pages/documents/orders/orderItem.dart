import 'package:dsk_docflow/controllers/Controller.dart';
import 'package:dsk_docflow/models/documents/ItemOreders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../generated/l10n.dart';
import '../../../models/UiC.dart';
import '../../../models/documents/OrderGoods.dart';

List<TextEditingController> _namecontrollers = [];
List<TextEditingController> _quantitycontrollers = [];
late List<ItemOreders> _itemorders;

class OrderItem extends StatefulWidget {
  const OrderItem({Key? key}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  late OrderItemDataGridSource _orderItemDataGridSource;
  final Controller _controller = Get.find();

  getListControllers() {
    for (int i = 0; i < _controller.ordergood.value.itemOreders!.length; i++) {
      _namecontrollers.add(TextEditingController(
          text: _controller.ordergood.value.itemOreders![i].name));
    }
    for (int i = 0; i < _controller.ordergood.value.itemOreders!.length; i++) {
      _quantitycontrollers.add(TextEditingController(
          text:
              _controller.ordergood.value.itemOreders![i].quantity.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    getListControllers();

    _orderItemDataGridSource = OrderItemDataGridSource(
        itemorders: _controller.ordergood.value.itemOreders!);

    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
            alignment: Alignment.topLeft,
            child: ElevatedButton(
                onPressed: () {
                  ItemOreders _emptyItem = ItemOreders(name: "", quantity: 0);
                  _controller.ordergood.value.itemOreders!.add(_emptyItem);

                  setState(() {
                    _orderItemDataGridSource.rows.add(DataGridRow(cells: []));
                   });
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey[800])),
                child: Text(S.of(context).add))),
        SizedBox(
          height: 20,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blue.shade800)),
            child: Card(
                elevation: 5,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: SfDataGridTheme(
                        data: SfDataGridThemeData(
                          headerColor: Colors.grey[700],
                          rowHoverColor: Colors.grey,
                          gridLineStrokeWidth: 1,
                          rowHoverTextStyle: TextStyle(
                            color: Colors.white,
                            // fontSize: 10,
                          ),
                        ),
                        child: SfDataGrid(
                          source: _orderItemDataGridSource,
                          selectionMode: SelectionMode.single,
                          headerGridLinesVisibility:
                              GridLinesVisibility.vertical,
                          columnWidthMode: ColumnWidthMode.fill,
                          isScrollbarAlwaysShown: true,
                          shrinkWrapRows: true,
                          // allowFiltering: true,
                          allowSorting: true,
                          allowEditing: true,
                          gridLinesVisibility: GridLinesVisibility.both,
                          onQueryRowHeight: (details) {
                            return UiC.datagrig_height;
                          },
                          headerRowHeight: UiC.datagrig_height,
                          onCellDoubleTap: ((cell) {
                            _controller.ordergood.value = _controller.ordergoods
                                .value[cell.rowColumnIndex.rowIndex - 1];
                            _controller.page.value = 6;
                          }),
                          columns: [
                            GridColumn(
                                columnName: 'num',
                                width: 50,
                                label: Center(
                                  child: Text(
                                    S.of(context).num,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                            GridColumn(
                              columnName: 'name',
                              // width: MediaQuery.of(context).size.width/2,
                              label: Center(
                                child: Text(
                                  S.of(context).name,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'quantity',
                              // width: MediaQuery.of(context).size.width/2,
                              label: Center(
                                child: Text(
                                  S.of(context).quantity,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            GridColumn(
                                columnName: "delete",
                                maximumWidth: 150,
                                label: Container(
                                    padding: EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      S.of(context).delete,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ))),
                          ],
                        ))))),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Row(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey[800])),
                      child: Text(S.of(context).save))),
              SizedBox(
                width: 50,
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey[800])),
                      child: Text(S.of(context).cancel))),
            ],
          ),
        )
      ],
    );
  }
}

class OrderItemDataGridSource extends DataGridSource {
  OrderItemDataGridSource({required List<ItemOreders> itemorders}) {
    _itemorders = itemorders;
    updateRows();
  }

  void updateRows() {
    dataGridRows = _itemorders
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: 'num', value: _itemorders.indexOf(e) + 1),
              DataGridCell<String>(columnName: 'name', value: e.name!),
              DataGridCell<double>(columnName: 'quantity', value: e.quantity),
              DataGridCell<Icon>(
                  columnName: 'delete', value: Icon(Icons.delete)),
            ]))
        .toList();
  }

  // void newRows() {
  //   dataGridRows = _itemorders
  //       .map<DataGridRow>((e) => DataGridRow(cells: [
  //     DataGridCell<int>(
  //         columnName: 'num', value: _itemorders.length),
  //     DataGridCell<String>(columnName: 'name', value: ""),
  //     DataGridCell<double>(columnName: 'quantity', value: 0),
  //     DataGridCell<Icon>(
  //         columnName: 'delete', value: Icon(Icons.delete)),
  //   ]))
  //       .toList();
  // }
  //
  // void updateDataGridSource() {
  //   notifyListeners();
  // }

  late List<DataGridRow> dataGridRows;

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[0].value.toString()),
      ),
      Container(
        // alignment: Alignment.center,
        // padding: EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          // textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          controller: _namecontrollers[rows.indexOf(row)],
          decoration: InputDecoration(
              isCollapsed: true,
              // isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10)),
        ),
      ),
      Container(
        // alignment: Alignment.center,
        // padding: EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          // textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          controller: _quantitycontrollers[rows.indexOf(row)],
          decoration: InputDecoration(
              isCollapsed: true,
              // isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10)),
        ),
      ),
      Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: row.getCells()[3].value),
    ]);
  }
}
