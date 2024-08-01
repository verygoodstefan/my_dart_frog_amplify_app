import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_data_source/amplify_data_source.dart';
import 'package:amplify_data_source/models/ModelProvider.dart';
import 'package:dart_frog/dart_frog.dart';

import '../amplify_outputs.dart';

final amplifyInstance = AmplifyClass();

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(
    // this provider should read a AmplifyClass instance
    // and provide it
    provider<AmplifyDataSource>((_) {
      return AmplifyDataSource(api: Amplify.API);
    }),
    //need one more provider that returns a configured
    // amplify class instance (this one will be future)
  );
}
