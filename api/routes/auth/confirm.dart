import 'dart:convert';
import 'dart:io';

import 'package:amplify_user_repository/amplify_user_repository.dart';
import 'package:api/helpers/request_mapper.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => await _post(context),
    _ => Response(statusCode: 405, body: 'Method Not Allowed'),
  };
}

Future<Response> _post(RequestContext context) async {
  late final Map<String, dynamic> requestBody;
  try {
    requestBody = await context.request.map();
  } catch (e) {
    print(e);
    return Response(statusCode: HttpStatus.badRequest);
  }

  final result = await context.read<AmplifyUserRepository>().confirmSignUp(
        username: requestBody['username'] as String,
        confirmationCode: requestBody['confirmationCode'] as String,
      );

  final responseBody = {
    'userId': result.userId,
    'nextStep': result.nextStep,
    'isSignUpComplete': result.isSignUpComplete,
  };

  return Response(body: jsonEncode(responseBody));
}
