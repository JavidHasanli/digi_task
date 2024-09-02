import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ISharedPreferenceService {
  void saveString(String key, String value);
  void saveBool(String key, bool value);
  void saveInt(String key, int value);
  String readString(String key);
  bool? readBool(String key);
  int readInt(String key);
  void clear();
}

final class SharedPreferenceService implements ISharedPreferenceService {
  SharedPreferenceService() {
    init();
  }
  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  @override
  Future<void> saveString(String key, String value) async {
    await _prefsInstance?.setString(key, value);
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    await _prefsInstance?.setBool(key, value);
  }

  @override
  Future<void> saveInt(String key, int value) async {
    await _prefsInstance?.setInt(key, value);
  }

  @override
  Future<void> clear() async {
    await _prefsInstance?.clear();
  }

  @override
  bool? readBool(String key) {
    return _prefsInstance?.getBool(key) ?? false;
  }

  @override
  int readInt(String key) {
    return _prefsInstance?.getInt(key) ?? 0;
  }

  @override
  String readString(String key) {
    return _prefsInstance?.getString(key) ?? 'Empty';
  }
}
