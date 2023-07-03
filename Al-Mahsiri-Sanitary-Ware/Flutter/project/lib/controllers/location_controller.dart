import 'package:geolocator/geolocator.dart';

class LocationController {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('خدمة الموقع معطلة يرجى تفعليها لإتمام العملية');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
            'تم رفض أذونات الموقع يرجى السماح لها لإتمام العملية');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'أذونات الموقع مرفوضة بشكل دائم ، ولا يمكننا طلب أذونات');
    }
    return await Geolocator.getCurrentPosition();
  }
}
