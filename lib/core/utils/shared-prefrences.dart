import 'package:get_storage/get_storage.dart';

class LocalDB {
  static final sharedPreference = GetStorage();

  static dataStoreWrite(dynamic json) {
    sharedPreference.write("data", json);
  }

  static Future<void> dataStoreRead(String json) {
    return sharedPreference.read("data");
  }
}
