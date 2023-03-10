import 'package:dsk_docflow/controllers/ApiConnector.dart';
import 'package:dsk_docflow/models/Department.dart';
import 'package:dsk_docflow/models/Position.dart';
import 'package:dsk_docflow/models/Warehouse.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  final api = ApiConnector();
  var departments = <Department>[].obs;
  var objecterror = false.obs;
  Department? department;
  var positions = <Position>[].obs;
  Position? position;
  var warehouses = <Warehouse>[].obs;
  Warehouse? warehouse;

  @override
  onInit() {
    fetchObjects("department");
    fetchObjects("position");
    fetchObjects("warehouse");

    super.onInit();
  }

  fetchObjects(String data) async {
    final json = await api.getAll("${data}/get");
    if (data ==  "department") {
      List<Department> loadDepartment =
          json.map((e) => Department.fromJson(e)).toList();
      departments.value = loadDepartment;
    } else if (data ==  "position") {
      List<Position> loadPosition =
          json.map((e) => Position.fromJson(e)).toList();
      positions.value = loadPosition;
    } else if (data ==  "warehouse") {
      List<Warehouse> loadWarehouse =
          json.map((e) => Warehouse.fromJson(e)).toList();
      warehouses.value = loadWarehouse;
    } else {
      objecterror.value = true;
    }
  }

  Future<dynamic?> changeObject(String url, dynamic object) async {
    dynamic result;
    final json = await api.save(url, object);
    if (object is Department) {
      result = Department.fromJson(json);
    } else if (object is Position) {
      result = Position.fromJson(json);
    }
    return result;
  }

  Future<bool> deleteById(url, id) async {
    return await api.deleteById(url, id);
  }
}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controller>(() => Controller());
  }
}
