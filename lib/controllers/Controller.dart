import 'package:dsk_docflow/controllers/ApiConnector.dart';
import 'package:dsk_docflow/models/Department.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  final api = ApiConnector();
  Department? department;

  @override
  onInit() {
    super.onInit();
    fetchdepartment();
  }

  fetchdepartment() async {
    final json = await api.getAll("department/get");
    Department loadDepartment = Department.fromJson(json);

    if (loadDepartment != null) {
      department = loadDepartment;
    }
    update();
  }
}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controller>(() => Controller());
  }
}
