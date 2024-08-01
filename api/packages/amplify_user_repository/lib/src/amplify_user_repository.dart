import 'package:amplify_core/amplify_core.dart';

/// {@template amplify_user_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class AmplifyUserRepository {
  /// {@macro amplify_user_repository}
  const AmplifyUserRepository({required AuthCategory auth}) : _auth = auth;

  final AuthCategory _auth;

  /// Get the current use.
  Future<AuthUser> getCurrentUser() async {
    final session = await _auth.fetchAuthSession();
    final user = await _auth.getCurrentUser();
    user.userId;
    final details = user.signInDetails.toJson();
    return _auth.getCurrentUser();
  }
}
