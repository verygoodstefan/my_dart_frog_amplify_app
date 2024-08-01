import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:api/amplify_outputs.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Amplify.addPlugin(AmplifyAuthCognito());
  await Amplify.configure(amplifyConfig);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignOutButton(),
                Text('TODO Application'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
