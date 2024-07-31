import 'dart:io';

import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_data_source/amplify_data_source.dart';
import 'package:dart_frog/dart_frog.dart';
import 'amplify_outputs.dart';

Future<void> init(InternetAddress ip, int port) async {
  final dataSource = AmplifyDataSource();

  final amplify = AmplifyClass();
  //do we need this sort of a setter in the setup?
  // if so, where does this have to be?
  // and then, do we have to ensure that we are using
  // this amplify (AmplifyClass.instance) whenever we
  // use dependencies?
  Amplify = amplify;
  // await amplify.addPlugin(dataSource.api);
  // await amplify.configure(amplifyConfig);
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) =>
    serve(handler, ip, port);
