import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_user_repository/amplify_user_repository.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      // .use(
      //   bearerAuthentication<AuthUser>(
      //     authenticator: (context, token) async {
      //       // will need to validate token
      //       // https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-tokens-verifying-a-jwt.html
      //       return context.read<AmplifyUserRepository>().getCurrentUser();
      //     },
      //   ))
      .use(
    provider<AmplifyUserRepository>((_) {
      return AmplifyUserRepository(auth: Amplify.Auth);
    }),
  );
}
