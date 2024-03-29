import 'package:dsk_docflow/controllers/Controller.dart';
import 'package:dsk_docflow/models/UiC.dart';
import 'package:dsk_docflow/widgets/dskAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../generated/l10n.dart';
import '../../models/catalogs/Department.dart';


Controller _controller = Get.find();
List<dynamic> _objects = [];
dynamic _object;
late ObjectDataGridSource _objectDataGridSource;
final _keyForm = GlobalKey<FormState>();

class WarehousePage extends GetView<Controller> {
  WarehousePage() : super();



  @override
  Widget build(BuildContext context) {
    if (_controller.nameobject.value == "warehouse") {
      _objects = _controller.warehouses.value;
    } else if (_controller.nameobject.value == "department") {
      _objects = _controller.departments.value;
    } else if (_controller.nameobject.value == "position") {
      _objects = _controller.positions.value;
    }
    _objectDataGridSource = ObjectDataGridSource(_objects);

    return SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: ListView(children: [
            SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.topLeft,
                child: ElevatedButton(
                    onPressed: () {
                      _object = null;
                      showDialogMeneger(context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.grey[800])),
                    child: Text("Добавить"))),
            SizedBox(
              height: 20,
            ),
            Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
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
                              source: _objectDataGridSource,
                              selectionMode: SelectionMode.single,
                              headerGridLinesVisibility:
                              GridLinesVisibility.vertical,
                              columnWidthMode: ColumnWidthMode.fill,
                              // allowFiltering: true,
                              allowSorting: true,
                              allowEditing: true,
                              isScrollbarAlwaysShown: true,
                              headerRowHeight: UiC.datagrig_height,
                              onQueryRowHeight: (details) {
                                return UiC.datagrig_height;
                              },
                              gridLinesVisibility: GridLinesVisibility.both,
                              onCellTap: (cell) async {
                                if (cell.rowColumnIndex.rowIndex > -1) {
                                  if (cell.column.columnName != 'delete') {
                                    _object = _objects[
                                    cell.rowColumnIndex.rowIndex - 1];
                                    showDialogMeneger(context);
                                  }
                                  if (cell.column.columnName == 'delete') {
                                    await showDialog<void>(
                                      context: context,
                                      barrierDismissible: true,
                                      // false = user must tap button, true = tap outside dialog
                                      builder: (BuildContext dialogContext) {
                                        return AlertDialog(
                                          content: Text('Хотите удалить ?'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('Да'),
                                              onPressed: () {
                                                _controller
                                                    .deleteById(
                                                    "${_controller.nameobject.value}/delete",
                                                    _objects[cell
                                                        .rowColumnIndex
                                                        .rowIndex -
                                                        1]
                                                        .id
                                                        .toString())
                                                    .then((value) {
                                                  _controller.fetchObjects(
                                                      _controller.nameobject.value);
                                                });
                                                Navigator.of(dialogContext)
                                                    .pop(); // Dismiss alert dialog
                                              },
                                            ),
                                            TextButton(
                                              child: Text('Нет'),
                                              onPressed: () {
                                                Navigator.of(dialogContext)
                                                    .pop(); // Dismiss alert dialog
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                              columns: [
                                GridColumn(
                                    columnName: 'id',
                                    width: 50,
                                    label: Center(
                                      child: Text(
                                        S
                                            .of(context)
                                            .num,
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
                                      S
                                          .of(context)
                                          .name,
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
                                          S
                                              .of(context)
                                              .delete,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ))),
                              ]),
                        ))))
          ]),
        ));
  }
}

Future<void> showDialogMeneger(BuildContext context) async {
  TextEditingController _nameController = TextEditingController();
  String _id = '';
  if (_object != null) {
    _nameController.text = _object!.name!;
    _id = _object!.id.toString();
  } else {
    _id = '';
    _nameController.text = '';
  }

  return await showDialog<void>(
    context: context,
    barrierDismissible: true,
    // false = user must tap button, true = tap outside dialog
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(S
            .of(context)
            .catalog_dialog_title),
        content: Container(
            width: MediaQuery
                .of(context)
                .size
                .width / 3,
            height: MediaQuery
                .of(context)
                .size
                .height / 3,
            child: Form(
                key: _keyForm,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text('№ ${_id}')),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S
                                .of(context)
                                .validate;
                          }
                        },
                        style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                            color: Colors.black),
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            //Theme.of(context).backgroundColor,
                            labelText: S
                                .of(context)
                                .name,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 0.5, color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 0.5, color: Colors.black)))),
                  ],
                ))),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (!_keyForm.currentState!.validate()) {
                return;
              }

              if (_object == null) {
                _object = Department();
              }
              _object!.name = _nameController.text;
              _controller.changeObject("${_controller.nameobject.value}/save", _object).then((value) {
                _controller.fetchObjects(_controller.nameobject.value);
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              });
            },
            child: Text(S
                .of(context)
                .save),
          ),
          TextButton(
            child: Text(S
                .of(context)
                .cancel),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Dismiss alert dialog
            },
          ),
        ],
      );
    },
  );
}

class ObjectDataGridSource extends DataGridSource {
  ObjectDataGridSource(List<dynamic> objects) {
    dataGridRows = objects
        .map<DataGridRow>((e) =>
        DataGridRow(cells: [
          DataGridCell<int>(
              columnName: 'id', value: objects.indexOf(e) + 1),
          DataGridCell<String>(columnName: 'name', value: e.name),
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
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[1].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: row.getCells()[2].value,
      ),
    ]);
  }
}
