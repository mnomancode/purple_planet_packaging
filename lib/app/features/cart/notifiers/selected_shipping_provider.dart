import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/cart/cart_model.dart';
import '../../../provider/shared_preferences_storage_service_provider.dart';
import '../../../services/local/shared_prefs_storage_service.dart';

part 'selected_shipping_provider.g.dart';

@riverpod
class SelectedShippingMethodNotifier extends _$SelectedShippingMethodNotifier {
  late final SharedPrefsService _storageService;

  @override
  Rate? build() {
    _storageService = ref.read(storageServiceProvider);

    return _loadSelectedShippingMethod(); // Load state at build
  }

  // ✅ Load from SharedPrefsService
  Rate? _loadSelectedShippingMethod() {
    final jsonRate = _storageService.getString('selectedShippingMethod');
    if (jsonRate != null) {
      return Rate.fromJson(json.decode(jsonRate.toString()));
    }
    return null;
  }

  // ✅ Save to SharedPrefsService
  Future<void> _saveSelectedShippingMethod(Rate? rate) async {
    if (rate != null) {
      await _storageService.set('selectedShippingMethod', json.encode(rate.toJson()));
    }
  }

  // ✅ Update state and persist it
  void setSelectedShippingMethod(Rate? rate) {
    state = rate;
    _saveSelectedShippingMethod(rate);
  }
}
