import 'dart:async';
import 'dart:convert';

import 'package:purple_planet_packaging/app/models/orders/order_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/http_provider.dart';
import 'storage_service.dart';

class SharedPrefsService implements StorageService {
  SharedPreferences? sharedPreferences;

  final Completer<SharedPreferences> initCompleter = Completer<SharedPreferences>();

  @override
  void init() {
    initCompleter.complete(SharedPreferences.getInstance());
  }

  @override
  bool get hasInitialized => sharedPreferences != null;

  @override
  Future<Object?> get(String key) async {
    sharedPreferences = await initCompleter.future;
    return sharedPreferences!.get(key);
  }

  @override
  Future<void> clear() async {
    sharedPreferences = await initCompleter.future;
    await clearCookies();
    await sharedPreferences!.clear();
  }

  @override
  Future<bool> has(String key) async {
    sharedPreferences = await initCompleter.future;
    return sharedPreferences?.containsKey(key) ?? false;
  }

  @override
  Future<bool> remove(String key) async {
    sharedPreferences = await initCompleter.future;
    return await sharedPreferences!.remove(key);
  }

  @override
  Future<bool> set(String key, data) async {
    sharedPreferences = await initCompleter.future;
    return await sharedPreferences!.setString(key, data.toString());
  }

  FutureOr<String?> getEmail() async {
    return getString('email');
  }

  FutureOr<Shipping?> getShipping() async {
    final shipping = await get('shipping');
    if (shipping == null) return null;
    return Shipping.fromJson(json.decode(shipping.toString()));
  }

  FutureOr<Billing?> getBilling() async {
    final billing = await get('billing');
    if (billing == null) return null;
    return Billing.fromJson(json.decode(billing.toString()));
  }

  putString(String key, String value) async {
    sharedPreferences = await initCompleter.future;
    await sharedPreferences!.setString(key, value);
  }

  String? getString(String key) {
    return sharedPreferences?.getString(key);
  }

  void saveToken(String s) {
    putString('token', s);
  }

  String? getToken() {
    return getString('token');
  }
}
