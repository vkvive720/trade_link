import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

class UserProvider extends StateNotifier<User?> {
  // Initialize with null to indicate no user is logged in
  UserProvider() : super(null);

  // Setter: update user from JSON
  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

  // Clear the user (e.g. on logout)
  void signOut(){
    state=null;
  }

  void clearUser() {
    state = null;
  }
}

final userProvider = StateNotifierProvider<UserProvider, User?>(
      (ref) => UserProvider(),
);
