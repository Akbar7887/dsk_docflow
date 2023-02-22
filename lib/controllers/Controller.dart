import 'package:dsk_docflow/controllers/ApiConnector.dart';
import 'package:dsk_docflow/models/Department.dart';
import 'package:dsk_docflow/models/Position.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  final api = ApiConnector();
  var departments = <Department>[].obs;
  var objecterror = false.obs;
  Department? department;
  var positions = <Position>[].obs;
  Position? position;

  @override
  onInit() {
    fetchdepartment();
    fetchposition();
    super.onInit();
  }

  fetchdepartment() async {
    final json = await api.getAll("department/get");
    List<Department> loadDepartment =
        json.map((e) => Department.fromJson(e)).toList();

    if (loadDepartment.isNotEmpty) {
      departments.value = loadDepartment;
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

  fetchposition() async {
    final json = await api.getAll("position/get");
    List<Position> loadPosition =
        json.map((e) => Position.fromJson(e)).toList();

    if (loadPosition.isNotEmpty) {
      positions.value = loadPosition;
    } else {
      objecterror.value = true;
    }
  }
}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controller>(() => Controller());
  }
}
