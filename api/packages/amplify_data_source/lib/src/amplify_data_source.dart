import 'package:amplify_api_dart/amplify_api_dart.dart';
import 'package:amplify_data_source/models/ModelProvider.dart';
import 'package:uuid/uuid.dart';

/// {@template amplify_data_source}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class AmplifyDataSource {
  /// {@macro amplify_data_source}
  AmplifyDataSource({
    AmplifyAPIDart? api,
  }) : _api = api ??
            AmplifyAPIDart(
              options: APIPluginOptions(modelProvider: ModelProvider.instance),
            );

  final AmplifyAPIDart _api;

  /// Create a new $Todo.
  Future<Todo> createTodo() async {
    final newTodo = Todo(
      id: const Uuid().v4(),
      content: 'Random Todo ${DateTime.now().toIso8601String()}',
    );
    final request = ModelMutations.create(newTodo);
    final response = await _api.mutate(request: request).response;
    if (response.hasErrors) {
      throw Exception('Failed to create todo. Errors: ${response.errors}');
    }
    return response.data!;
  }

  /// Get all $Todo items.
  Future<PaginatedResult<Todo>> getTodos() async {
    final request = ModelQueries.list(Todo.classType);
    final response = await _api.query(request: request).response;
    if (response.hasErrors) {
      throw Exception('Failed to get todos. Errors: ${response.errors}');
    }
    if (response.data == null) {
      throw Exception('Failed to get todos. Data is null');
    }
    return response.data!;
  }

  /// Get a single $Todo item.
  Future<Todo> getTodo({required String id}) async {
    final todo = ModelQueries.get(Todo.classType, TodoModelIdentifier(id: id));
    final response = await _api.query(request: todo).response;
    if (response.hasErrors) {
      throw Exception('Failed to get todo. Errors: ${response.errors}');
    }
    if (response.data == null) {
      throw Exception('Failed to get todo. Data is null');
    }
    return response.data!;
  }

  /// Update a single $Todo item.
  Future<Todo> updateTodo({
    required String id,
    String? content,
    bool? isDone,
  }) async {
    final todo = await getTodo(id: id);
    final request = ModelMutations.update(
      todo.copyWith(
        content: content,
        isDone: isDone,
      ),
    );
    final response = await _api.mutate(request: request).response;
    if (response.hasErrors) {
      throw Exception('Failed to update todo. Errors: ${response.errors}');
    }
    if (response.data == null) {
      throw Exception('Failed to update todo. Data is null');
    }
    return response.data!;
  }

  /// Delete a single $Todo item.
  Future<void> deleteTodo({required String id}) async {
    final todo = await getTodo(id: id);
    final request = ModelMutations.delete(todo);
    final response = await _api.mutate(request: request).response;
    if (response.hasErrors) {
      throw Exception('Failed to delete todo. Errors: ${response.errors}');
    }
  }
}
