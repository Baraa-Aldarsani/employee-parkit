import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../model/garage_services_model.dart';
import '../../model/required_services_model.dart';
import 'api_services.dart';

class ServicesController extends GetxController{
      var services = <RequiredServicesModel>[].obs;
      var servicesGarage = <GarageServices>[].obs;
      RxInt done = RxInt(-1);
      @override
      void onInit() {
        fetchServices();
        servicesGarageModel();
      }
      Future<void> fetchServices()async{
        try{
         final fetchList = await ApiServices.fetchData();
         services.assignAll(fetchList);
        }catch(e){
          print(e.toString());
        }
      }

      Future<void> doneServices(int id) async{
        try{
          await ApiServices.done(id);
          update();
          print("Done...");
        }catch(e){
          print(e.toString());
        }
      }

      Future<void> servicesGarageModel() async{
        try{
          final fetchData  = await ApiServices.fetchServices();
          servicesGarage.assignAll(fetchData);
        }catch(e){
          print(e.toString());
        }
      }

      Future<void> addServicesForCustomer(int userId,int servId) async{
        try{
              await ApiServices.addServ(userId,servId);
              EasyLoading.showSuccess('Successfully Add',
                  maskType: EasyLoadingMaskType.black,
                  duration: const Duration(milliseconds: 500));
        }catch(e){
          print(e.toString());
        }
      }

}