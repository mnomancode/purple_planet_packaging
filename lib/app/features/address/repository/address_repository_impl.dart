import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'address_repository.dart';

class AddressRepositoryImpl extends AddressRepository {
  // TODO add your methods here
}

final addressRepositoryProvider = Provider<AddressRepository>((ref) {
  return AddressRepositoryImpl();
});
