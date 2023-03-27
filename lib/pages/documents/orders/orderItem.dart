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

late OrderItemDataGridSource _orderItemDataGridSource;
final Controller _controller = Get.find();

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _orderItemDataGridSource =
        OrderItemDataGridSource(_controller.ordergood.value.itemOreders!);

    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                        fontSize: 15,
                      ),
                    ),
                    child: SfDataGrid(
                      source: _orderItemDataGridSource,
                      selectionMode: SelectionMode.single,
                      headerGridLinesVisibility: GridLinesVisibility.vertical,
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
                            .ordergoods.value[cell.rowColumnIndex.rowIndex - 1];
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
                    )))));
  }
}

class OrderItemDataGridSource extends DataGridSource {
  OrderItemDataGridSource(List<ItemOreders> itemorders) {
    dataGridRows = itemorders
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: 'num', value: itemorders.indexOf(e) + 1),
              DataGridCell<String>(columnName: 'name', value: e.name!),
              DataGridCell<double>(columnName: 'quantity', value: e.quantity),
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
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: row.getCells()[3].value),
    ]);
  }
}
