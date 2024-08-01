import 'dart:convert';
import 'dart:io';

import 'package:amplify_data_source/amplify_data_source.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => await _get(context),
    HttpMethod.post => await _post(context),
    _ => Response(statusCode: 405, body: 'Method Not Allowed'),
  };
}

Future<Response> _get(RequestContext context) async {
  try {
    final todos = await context.read<AmplifyDataSource>().getTodos();
    return Response(
      body: jsonEncode(todos.toJson()),
    );
  } on Exception catch (e) {
    return Response(
      statusCode: HttpStatus.internalServerError,
      body: jsonEncode({
        'error': e,
      }),
    );
  }
}

Future<Response> _post(RequestContext context) async {
  try {
    final result = await context.read<AmplifyDataSource>().createTodo();
    return Response(
      body: jsonEncode(result.toJson()),
    );
  } on Exception catch (e) {
    return Response(
      statusCode: HttpStatus.internalServerError,
      body: jsonEncode({
        'error': e,
      }),
    );
  }
}
