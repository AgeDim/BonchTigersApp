import 'package:bonch_tigers_app/services/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class MainPresenter {
  final FirebaseAuth _auth;
  final DatabaseReference _database;

  MainPresenter(this._auth, this._database);

  Future<String?> getCurrentUserRole() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        final snapshot =
            await _database.child('users/${currentUser.uid}/role').once();
        final role = snapshot.snapshot.value as String?;
        return role;
      }
    } catch (error) {
      CustomLogger.error('Error retrieving user role: $error');
    }
    return null;
  }
}
