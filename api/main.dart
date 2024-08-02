import 'dart:io';

import 'package:amplify_auth_cognito_dart/amplify_auth_cognito_dart.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_secure_storage_dart/amplify_secure_storage_dart.dart';
import 'package:api/amplify_outputs.dart';
import 'package:dart_frog/dart_frog.dart';

Future<void> init(InternetAddress ip, int port) async {
  final auth = AmplifyAuthCognitoDart(
    secureStorageFactory: AmplifySecureStorageDart.factoryFrom(
      macOSOptions:
          // ignore: invalid_use_of_visible_for_testing_member
          MacOSSecureStorageOptions(useDataProtection: false),
    ),
  );
  await Amplify.addPlugin(auth);
  await Amplify.configure(amplifyConfig);
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) =>
    serve(handler, ip, port);
