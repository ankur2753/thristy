import 'package:permission_handler/permission_handler.dart';

class PermissionsServices {
  Future<bool> cameraPermissions() async {
    if (await Permission.camera.isGranted) {
      return true;
    }
    if (await Permission.camera.isDenied) {
      if (await Permission.camera.request() == PermissionStatus.denied) {
        throw Exception("");
      } else {
        Future.value(true);
      }
    }
    return Future.value(false);
  }
}
