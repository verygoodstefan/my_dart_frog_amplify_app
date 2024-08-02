import 'package:amplify_auth_cognito_dart/amplify_auth_cognito_dart.dart';
import 'package:amplify_core/amplify_core.dart';

/// {@template amplify_user_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class AmplifyUserRepository {
  /// {@macro amplify_user_repository}
  const AmplifyUserRepository({required AuthCategory auth}) : _auth = auth;

  final AuthCategory _auth;

  /// Get the current user.
  Future<AuthUser> getCurrentUser() => _auth.getCurrentUser();

  /// Sign out the current user.
  Future<void> signOut() => _auth.signOut();

  /// Sign in with a username and password.
  Future<SignInResult> signIn({
    required String username,
    required String password,
  }) {
    return _auth.signIn(
      username: username,
      password: password,
      options: const SignInOptions(
        pluginOptions: CognitoSignInPluginOptions(
          authFlowType: AuthenticationFlowType.customAuthWithSrp,
        ),
      ),
    );
  }

  /// Sign up with a username and password.
  Future<SignUpResult> signUp({
    required String username,
    required String password,
  }) async =>
      _auth.signUp(
        username: username,
        password: password,
      );
}
