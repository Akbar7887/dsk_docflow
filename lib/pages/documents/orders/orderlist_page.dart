import 'package:dsk_docflow/models/documents/OrderGoods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../controllers/Controller.dart';
import '../../../generated/l10n.dart';
import '../../../models/UiC.dart';

late OrderDataGridSource _orderDataGridSource;
Controller _controller = Get.find();

class OrderListPage extends GetView<Controller> {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _orderDataGridSource = OrderDataGridSource(_controller.ordergoods.value);
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListView(children: [
              SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey[800])),
                      child: Text("Добавить"))),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade800)),
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
                                  fontSize: 15,
                                ),
                              ),
                              child: SfDataGrid(
                                source: _orderDataGridSource,
                                selectionMode: SelectionMode.single,
                                headerGridLinesVisibility:
                                    GridLinesVisibility.vertical,
                                columnWidthMode: ColumnWidthMode.fill,
                                isScrollbarAlwaysShown: true,
                                // allowFiltering: true,
                                allowSorting: true,
                                allowEditing: true,
                                gridLinesVisibility: GridLinesVisibility.both,
                                onQueryRowHeight: (details) {
                                  return UiC.datagrig_height;
                                },
                                headerRowHeight: UiC.datagrig_height,
                                onCellDoubleTap: ((cell) {
                                  _controller.ordergood.value = _controller
                                      .ordergoods
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
                                      columnName: 'id',
                                      width: 100,
                                      label: Center(
                                        child: Text(
                                          S.of(context).id,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  GridColumn(
                                    columnName: 'datecreate',
                                    // width: MediaQuery.of(context).size.width/2,
                                    label: Center(
                                      child: Text(
                                        S.of(context).date,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'worker',
                                    // width: MediaQuery.of(context).size.width/2,
                                    label: Center(
                                      child: Text(
                                        S.of(context).personal,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'warehouse',
                                    // width: MediaQuery.of(context).size.width/2,
                                    label: Center(
                                      child: Text(
                                        S.of(context).warehouse,
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
                              )))))
            ])));
  }
}

class OrderDataGridSource extends DataGridSource {
  OrderDataGridSource(List<OrderGoods> ordergoods) {
    dataGridRows = ordergoods
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: 'num', value: ordergoods.indexOf(e) + 1),
              DataGridCell<String>(columnName: 'id', value: e.id.toString()),
              DataGridCell<String>(
                  columnName: 'datecreate',
                  value: UiC.dateFormat.format(DateTime.parse(e.datecreate!))),
              DataGridCell<String>(columnName: 'worker', value: e.worker!.name),
              DataGridCell<String>(
                  columnName: 'warehouse', value: e.warehouse!.name),
              DataGridCell<Icon>(
                  columnName: 'delete', value: Icon(Icons.delete)),
            ]))
        .toList();
  }

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
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[1].value.toString()),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[2].value.toString()),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[3].value.toString()),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[4].value.toString()),
      ),
      Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: row.getCells()[5].value),
    ]);
  }
}
