import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'custom_print_repository.dart';

class CustomPrintRepositoryImpl extends CustomPrintRepository {
  // TODO add your methods here
}

final customPrintRepositoryProvider = Provider<CustomPrintRepository>((ref) {
  return CustomPrintRepositoryImpl();
});
