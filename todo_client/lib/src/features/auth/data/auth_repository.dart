import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../domain/app_user.dart';

class AuthRepository {

  final BehaviorSubject<AppUser?> _authState = BehaviorSubject.seeded(null);
  
  AppUser? get currentUser => _authState.value;

  Stream<AppUser?> authStateChanges() {
    return _authState.stream;
  }

  void signIn() {
    _authState.add(AppUser("98e99-some-test-uid-jkh37"));
  }

  void signOut() {
    _authState.add(null);
  }

  Future<String> getAuthToken() {
    return Future.value("not yet implemented");
  }
}

final authRepositoryProvider = Provider((ref) {
  return AuthRepository();
});