import 'package:dsk_docflow/controllers/ApiConnector.dart';
import 'package:dsk_docflow/models/Department.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  final api = ApiConnector();
  var departments = <Department>[].obs;
  var departmenterror = false.obs;

  @override
  onInit() {
    fetchdepartment();
    super.onInit();
  }

  fetchdepartment() async {
    final json = await api.getAll("department/get");
    List<Department> loadDepartment =
        json.map((e) => Department.fromJson(e)).toList();

    if(loadDepartment.isNotEmpty){
      departments.value = loadDepartment;
    }else{
      departmenterror.value = true;
    }
  }
}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controller>(() => Controller());
  }
}
