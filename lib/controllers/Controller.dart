import 'package:dsk_docflow/controllers/ApiConnector.dart';
import 'package:dsk_docflow/models/Department.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  final api = ApiConnector();
  List<Department> departments = <Department>[].obs;

  @override
  onInit() {
    super.onInit();
    fetchdepartment();
  }

  fetchdepartment() async {
    final json = await api.getAll("department/get");
    List<Department> loadDepartment = json.map((e) => Department.fromJson(e));

    if (loadDepartment.isNotEmpty) {
      departments = loadDepartment;
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
