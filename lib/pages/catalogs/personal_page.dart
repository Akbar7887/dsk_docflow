import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../controllers/Controller.dart';
import '../../generated/l10n.dart';
import '../../models/UiC.dart';
import '../../models/catalogs/Department.dart';
import '../../models/catalogs/Personal.dart';

String? data;
Controller _controller = Get.find();

late PersonalDataGridSource _personalDataGridSource;
final _keyForm = GlobalKey<FormState>();

class PersonalPage extends StatelessWidget {
  const PersonalPage({Key? key}) : super(key: key);

  Future<void> showDialogMeneger(BuildContext context) async {
    TextEditingController _nameController = TextEditingController();
    String _id = '';
    if (_controller.personal.value != null) {
      _nameController.text = _controller.personal.value.name!;
      _id = _controller.personal.value.id.toString();
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
          title: Text(S.of(context).catalog_dialog_title),
          content: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height / 3,
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
                              return S.of(context).validate;
                            }
                          },
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w200,
                              color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              //Theme.of(context).backgroundColor,
                              labelText: S.of(context).name,
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

                if (_controller.personal.value == null) {
                  _controller.personal.value = Personal();
                }
                _controller.personal.value!.name = _nameController.text;
                _controller
                    .changeObject("${data}/save", _controller.personal.value)
                    .then((value) {
                  _controller.fetchObjects("personal");
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                });
              },
              child: Text(S.of(context).save),
            ),
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      _personalDataGridSource =
          PersonalDataGridSource(_controller.personals.value);

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
                    _controller.personal = Personal().obs;
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
                            source: _personalDataGridSource,
                            selectionMode: SelectionMode.single,
                            headerGridLinesVisibility:
                                GridLinesVisibility.vertical,
                            columnWidthMode: ColumnWidthMode.fill,
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
                                if (cell.rowColumnIndex.columnIndex != 2) {
                                  _controller.personal.value = _controller
                                      .personals
                                      .value[cell.rowColumnIndex.rowIndex - 1];
                                  showDialogMeneger(context);
                                }
                                if (cell.rowColumnIndex.columnIndex == 2) {
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
                                                      "${data}/delete",
                                                      _controller
                                                          .personals
                                                          .value[cell
                                                                  .rowColumnIndex
                                                                  .rowIndex -
                                                              1]
                                                          .id
                                                          .toString())
                                                  .then((value) {
                                                _controller
                                                    .fetchObjects("personal");
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
                                    S.of(context).name,
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
                            ]),
                      ))))
        ]),
      ));
    });
  }
}

class PersonalDataGridSource extends DataGridSource {
  PersonalDataGridSource(List<dynamic> objects) {
    dataGridRows = objects
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: 'id', value: objects.indexOf(e) + 1),
              DataGridCell<String>(columnName: 'name', value: e.name),
              // DataGridCell<Icon>(columnName: 'edit', value: Icon(Icons.edit)),
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
      // Container(
      //     alignment: Alignment.center,
      //     padding: EdgeInsets.symmetric(horizontal: 16),
      //     child: row.getCells()[2].value),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: row.getCells()[2].value,
      ),
    ]);
  }
}
