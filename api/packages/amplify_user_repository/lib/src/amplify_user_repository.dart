import 'package:amplify_auth_cognito_dart/amplify_auth_cognito_dart.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:password_dart/password_dart.dart';

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

  /// Sign in with a username.
  Future<SignInResult> signIn({
    required String username,
  }) {
    // this would be an incomplete sign-in, since there would need
    // to be a confirmSignIn method where the user enters
    // the randomly generated number that is created in the lambda
    //
    // how would we send the randomly generated number to the user?
    // email? just show it on the screen?
    return _auth.signIn(
      username: username,
      options: const SignInOptions(
        pluginOptions: CognitoSignInPluginOptions(
          authFlowType: AuthenticationFlowType.customAuthWithoutSrp,
        ),
      ),
    );
  }

  /// Sign up with a username and email.
  /// Email is used to confirm sign in.
  /// A confirmation code will be sent to the email.
  Future<SignUpResult> signUp({
    required String username,
    required String email,
  }) async {
    final password = 'Password###${UUID.getUUID()}';
    return _auth.signUp(
      username: username,
      password: password, //Password.hash(password, PBKDF2()),
      options: SignUpOptions(
        userAttributes: {
          AuthUserAttributeKey.email: email,
        },
      ),
    );
  }

  /// Confirm a sign up with a confirmation code.
  Future<SignUpResult> confirmSignUp({
    required String username,
    required String confirmationCode,
  }) async =>
      _auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
}
