import 'package:purple_planet_packaging/app/features/auth/providers/auth_state_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_loading_provider.g.dart';

@riverpod
bool isLoading(IsLoadingRef ref) {
  final authState = ref.watch(authStateNotifierProvider);

  return authState.isLoading;
}
