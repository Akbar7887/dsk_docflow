import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../models/UiC.dart';

late OrderDataGridSource _orderDataGridSource;

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(children: [
  //     SizedBox(
  //       height: 50,
  //     ),
  //     Container(
  //         width: 200,
  //         child: ElevatedButton(onPressed: () {}, child: Text("Добавить"))),
  //     Expanded(
  //         child: SfDataGridTheme(
  //             data: SfDataGridThemeData(
  //               headerColor: Colors.grey[700],
  //               rowHoverColor: Colors.grey,
  //               gridLineStrokeWidth: 1,
  //               rowHoverTextStyle: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 15,
  //               ),
  //             ),
  //             child: SfDataGrid(
  //               source: _orderDataGridSource,
  //               selectionMode: SelectionMode.single,
  //               headerGridLinesVisibility: GridLinesVisibility.vertical,
  //               columnWidthMode: ColumnWidthMode.fill,
  //               isScrollbarAlwaysShown: true,
  //               // allowFiltering: true,
  //               allowSorting: true,
  //               allowEditing: true,
  //               gridLinesVisibility: GridLinesVisibility.both,
  //               onQueryRowHeight: (details) {
  //                 return UiC.datagrig_height;
  //               },
  //               headerRowHeight: UiC.datagrig_height,
  //               onCellDoubleTap: ((cell) {}),
  //               columns: [],
  //             )))
  //   ]);
  // }
}

class OrderDataGridSource extends DataGridSource {
  OrderDataGridSource(this.dataGridRows);

  late List<DataGridRow> dataGridRows;

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    throw UnimplementedError();
  }
}
