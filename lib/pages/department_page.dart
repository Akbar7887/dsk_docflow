import 'package:dsk_docflow/controllers/Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../models/Department.dart';
import '../widgets/dskappbar.dart';

class DepartmentPage extends StatefulWidget {
  const DepartmentPage({Key? key}) : super(key: key);

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  Controller _controller = Get.put(Controller());

  List<Department> _departments = [];
  late DepartmentDataGridSource _departmentDataGridSource;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      _departmentDataGridSource =
          DepartmentDataGridSource(_controller.departments);

      return SafeArea(
          child: Scaffold(
              appBar: DskAppBar(), // extendBodyBehindAppBar: true,
              body: Padding(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("Добавить"))),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Card(
                                child: SfDataGridTheme(
                              data: SfDataGridThemeData(
                                headerColor: Colors.grey[700],
                                rowHoverColor: Colors.grey,
                                rowHoverTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              child: SfDataGrid(
                                  source: _departmentDataGridSource,
                                  selectionMode: SelectionMode.single,
                                  headerGridLinesVisibility:
                                      GridLinesVisibility.vertical,
                                  columnWidthMode:
                                      ColumnWidthMode.fill,
                                  // allowFiltering: true,
                                  allowSorting: true,
                                  allowEditing: true,
                                  columns: [
                                    GridColumn(
                                        columnName: 'id',
                                        width: 100,
                                        label: Center(
                                          child: Text(
                                            "№",
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
                                          "Наименование",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    GridColumn(
                                        columnName: "edit",
                                        maximumWidth: 150,
                                        label: Container(
                                            padding: EdgeInsets.all(16.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Изменить',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                    GridColumn(
                                        columnName: "delete",
                                        maximumWidth: 150,
                                        label: Container(
                                            padding: EdgeInsets.all(16.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Удалить',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                  ]),
                            ))))
                  ],
                ),
              )));
    });
  }
}

class DepartmentDataGridSource extends DataGridSource {
  DepartmentDataGridSource(List<Department> departments) {
    dataGridRows = departments
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<Icon>(columnName: 'edit', value: Icon(Icons.edit)),
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
    return DataGridRowAdapter(
        cells: [
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
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.edit)),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.delete),
          ),
        ]);
  }
}
