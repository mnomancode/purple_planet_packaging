import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  // TODO add your methods here
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl();
});
