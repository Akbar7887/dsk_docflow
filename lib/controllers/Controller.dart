import 'package:dsk_docflow/controllers/ApiConnector.dart';
import 'package:dsk_docflow/generated/l10n.dart';
import 'package:dsk_docflow/models/catalogs/Department.dart';
import 'package:dsk_docflow/models/Organization.dart';
import 'package:dsk_docflow/models/catalogs/Personal.dart';
import 'package:dsk_docflow/models/catalogs/Position.dart';
import 'package:dsk_docflow/models/catalogs/Warehouse.dart';
import 'package:dsk_docflow/models/documents/OrderGood.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  final api = ApiConnector();
  Rx<String> nameobject = "".obs;
  var departments = <Department>[].obs;
  var objecterror = false.obs;
  Rx<Department> department = Department().obs;
  var positions = <Position>[].obs;
  Rx<Position> position = Position().obs;
  var warehouses = <Warehouse>[].obs;
  Rx<Warehouse> warehouse = Warehouse().obs;
  var page = 0.obs;
  var organization = Organization().obs;
  var personals = <Personal>[].obs;
  var personal = Personal().obs;
  var ordergoods = <OrderGood>[].obs;

  Rx<OrderGood> ordergood = OrderGood().obs;


  @override
  onInit() {
    fetchListOrganization();

    fetchObjects("department");
    fetchObjects("position");
    fetchObjects("warehouse");
    fetchObjects("personal");
    fetchObjects("ordergoods");
    super.onInit();
  }

  fetchListOrganization() async {
    final json = await api.getfirst("organization/get");
    Organization loadedorg = Organization.fromJson(json);

    if (loadedorg != null) {
      organization.value = loadedorg;
      // notifyChildrens();
    }
    update();
  }

  fetchObjects(String data) async {
    final json = await api.getAll("${data}/get");
    if (data == "department") {
      List<Department> loadDepartment =
          json.map((e) => Department.fromJson(e)).toList();
      departments.value = loadDepartment;
    } else if (data == "position") {
      List<Position> loadPosition =
          json.map((e) => Position.fromJson(e)).toList();
      positions.value = loadPosition;
    } else if (data == "warehouse") {
      List<Warehouse> loadWarehouse =
          json.map((e) => Warehouse.fromJson(e)).toList();
      warehouses.value = loadWarehouse;
    } else if (data == "personal") {
      List<Personal> loadpersonal =
          json.map((e) => Personal.fromJson(e)).toList();
      personals.value = loadpersonal;
    } else if (data == "ordergoods") {
      List<OrderGood> loadorder =
      json.map((e) => OrderGood.fromJson(e)).toList();
      ordergoods.value = loadorder;
    } else {
      objecterror.value = true;
    }
  }

  Future<dynamic> changeObject(String url, dynamic object) async {
    dynamic result;
    final json = await api.save(url, object);
    if (object is Department) {
      result = Department.fromJson(json);
    } else if (object is Position) {
      result = Position.fromJson(json);
    } else if (object is Warehouse) {
      result = Warehouse.fromJson(json);
    } else if (object is Personal) {
      result = Personal.fromJson(json);
    }

    return result;
  }

  Future<dynamic> save(String url, dynamic object) async {
    dynamic result;
    final json = await api.save(url, object);
    return json;
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
