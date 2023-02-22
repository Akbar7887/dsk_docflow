import 'package:dsk_docflow/controllers/Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
    _departments = _controller.departments;
    _departmentDataGridSource = DepartmentDataGridSource(_departments);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child:
                      SfDataGrid(source: _departmentDataGridSource, columns: [
                    GridColumn(
                        columnName: 'id',
                        label: Center(
                          child: Text(
                            "№",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        )),
                    GridColumn(
                        columnName: 'name',
                        label: Center(
                          child: Text(
                            "Наименование",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        )),
                  ]))
            ],
          ),
        ));
  }
}

class DepartmentDataGridSource extends DataGridSource {
  DepartmentDataGridSource(List<Department> departments) {
    dataGridRows = departments
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name)
            ]))
        .toList();
  }

  late List<DataGridRow> dataGridRows;

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
