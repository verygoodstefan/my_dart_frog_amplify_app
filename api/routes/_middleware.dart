import 'package:amplify_data_source/amplify_data_source.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(
    provider<AmplifyDataSource>((_) {
      return AmplifyDataSource();
    }),
  );
}
