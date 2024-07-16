import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dart_frog/dart_frog.dart';

import 'amplify_outputs.dart';

Future<void> init(InternetAddress ip, int port) async {
  try {
    await Amplify.configure(amplifyConfig);
  } on AmplifyException catch (e) {
    safePrint('Error configuring Amplify: $e');
  }
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) =>
    serve(handler, ip, port);
