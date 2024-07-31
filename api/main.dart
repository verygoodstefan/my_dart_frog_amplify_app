import 'dart:io';

import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_data_source/amplify_data_source.dart';
import 'package:dart_frog/dart_frog.dart';
import 'amplify_outputs.dart';

Future<void> init(InternetAddress ip, int port) async {
  final dataSource = AmplifyDataSource();

  // final amplify = AmplifyClass();
  // await amplify.addPlugin(dataSource.api);
  // await amplify.configure(amplifyConfig);
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) =>
    serve(handler, ip, port);
