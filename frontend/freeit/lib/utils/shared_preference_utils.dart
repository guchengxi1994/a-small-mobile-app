import 'package:shared_preferences/shared_preferences.dart';

Future saveFileReadStatus(String key, double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble(key, value);
}

Future<double> getFileReadStatus(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  double? value = prefs.getDouble(key);
  if (null == value) {
    value = 0.0;
  }
  return value;
}
