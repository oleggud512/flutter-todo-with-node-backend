import 'package:todo_client/src/features/auth/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentToken {
  CurrentToken(AuthRepository authRepo) : _authRepo = authRepo;

  AuthRepository _authRepo;

  Future<String> call() {
    return _authRepo.getAuthToken();
  }
}

final currentTokenProvider = Provider((ref) {
  AuthRepository authRepo = ref.watch(authRepositoryProvider);
  return CurrentToken(authRepo);
});