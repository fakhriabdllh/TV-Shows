import 'package:get/instance_manager.dart';
import 'package:tv_shows/controller/movie_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<MovieController>(MovieController());
  }
}
