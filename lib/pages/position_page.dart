import 'package:dsk_docflow/controllers/Controller.dart';
import 'package:dsk_docflow/models/Position.dart';
import 'package:dsk_docflow/models/UiC.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../widgets/dskappbar.dart';

class PositionPage extends StatefulWidget {
  const PositionPage({Key? key}) : super(key: key);

  @override
  State<PositionPage> createState() => _PositionPageState();
}

class _PositionPageState extends State<PositionPage> {
  Controller _controller = Get.put(Controller());
  List<Position> _positions = [];
  Position? _position;
  late PositionDataGridSource _positionDataGridSource;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    _positions = _controller.positions;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      _positionDataGridSource = PositionDataGridSource(_controller.positions);

      return SafeArea(
          child: Scaffold(
              appBar: DskAppBar(), // extendBodyBehindAppBar: true,
              body: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: ListView(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Должности",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: UiC.font,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      child: ElevatedButton(
                          onPressed: () {
                            _position = null;
                            showDialogMeneger();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey[800])),
                          child: Text("Добавить"))),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: Container(
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
                                        source: _positionDataGridSource,
                                        selectionMode: SelectionMode.single,
                                        headerGridLinesVisibility:
                                            GridLinesVisibility.vertical,
                                        columnWidthMode: ColumnWidthMode.fill,
                                        // allowFiltering: true,
                                        allowSorting: true,
                                        allowEditing: true,
                                        gridLinesVisibility:
                                            GridLinesVisibility.both,
                                        onCellTap: (cell) async {
                                          if (cell.rowColumnIndex.rowIndex >
                                              -1) {
                                            if (cell.rowColumnIndex
                                                    .columnIndex ==
                                                2) {
                                              _position = _positions[
                                                  cell.rowColumnIndex.rowIndex -
                                                      1];
                                              showDialogMeneger();
                                            }
                                            if (cell.rowColumnIndex
                                                    .columnIndex ==
                                                3) {
                                              await showDialog<void>(
                                                context: context,
                                                barrierDismissible: true,
                                                // false = user must tap button, true = tap outside dialog
                                                builder: (BuildContext
                                                    dialogContext) {
                                                  return AlertDialog(
                                                    content: Text(
                                                        'Хотите удалить ?'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text('Да'),
                                                        onPressed: () {
                                                          _controller
                                                              .deleteById(
                                                                  "position/delete",
                                                                  _positions[cell
                                                                              .rowColumnIndex
                                                                              .rowIndex -
                                                                          1]
                                                                      .id
                                                                      .toString())
                                                              .then((value) {
                                                            _controller
                                                                .fetchposition();
                                                          });
                                                          Navigator.of(
                                                                  dialogContext)
                                                              .pop(); // Dismiss alert dialog
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text('Нет'),
                                                        onPressed: () {
                                                          Navigator.of(
                                                                  dialogContext)
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
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))),
                                        ]),
                                  )))))
                ]),
              )));
    });
  }

  Future<void> showDialogMeneger() async {
    TextEditingController _nameController = TextEditingController();
    String _id = '';
    if (_position != null) {
      _nameController.text = _position!.name!;
      _id = _position!.id.toString();
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
          title: Text('Форма для добавление или изменение'),
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
                              return "Просим заплнить наименование";
                            }
                          },
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w200,
                              color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              //Theme.of(context).backgroundColor,
                              labelText: "Наименование",
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

                if (_position == null) {
                  _position = Position();
                }
                _position!.name = _nameController.text;
                _controller
                    .changeObject("position/save", _position)
                    .then((value) {
                  _controller.fetchposition();
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                });
              },
              child: Text('Сохранить'),
            ),
            TextButton(
              child: Text('Отменить'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}

class PositionDataGridSource extends DataGridSource {
  PositionDataGridSource(List<Position> positions) {
    dataGridRows = positions
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: 'id', value: positions.indexOf(e) + 1),
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
          child: row.getCells()[2].value),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: row.getCells()[3].value,
      ),
    ]);
  }
}
