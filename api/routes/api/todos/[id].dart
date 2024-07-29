import 'dart:convert';
import 'dart:io';

import 'package:amplify_data_source/amplify_data_source.dart';
import 'package:amplify_data_source/models/Todo.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  return switch (context.request.method) {
    HttpMethod.get => await _get(context, id),
    HttpMethod.patch => await _patch(context, id),
    HttpMethod.delete => await _delete(context, id),
    _ => Response(statusCode: 405, body: 'Method Not Allowed'),
  };
}

Future<Response> _get(RequestContext context, String id) async {
  try {
    final todo = await context.read<AmplifyDataSource>().getTodo(
          id: id,
        );
    return Response(
      body: jsonEncode(todo.toJson()),
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

Future<Response> _patch(RequestContext context, String id) async {
  try {
    final request = Map<String, dynamic>.from(
      jsonDecode(await context.request.body()) as Map,
    );
    final todo = Todo.fromJson(request);
    final result = await context.read<AmplifyDataSource>().updateTodo(
          id: id,
          content: todo.content,
          isDone: todo.isDone,
        );
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

Future<Response> _delete(RequestContext context, String id) async {
  try {
    await context.read<AmplifyDataSource>().deleteTodo(
          id: id,
        );
    return Response(
      body: jsonEncode({
        'message': 'Todo deleted',
      }),
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
