import 'package:amplify_core/amplify_core.dart';

class Todo extends Model {
  final String id;
  final String name;
  final String description;
  final TemporalDateTime? createdAt;
  final TemporalDateTime? updatedAt;
  static const classType = const _TodoModelType();

  const Todo._internal({
    required this.id,
    required this.name,
    required this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Todo({
    required String name,
    required String description,
    String? id,
    TemporalDateTime? createdAt,
    TemporalDateTime? updatedAt,
  }) {
    return Todo(
      id: id ?? UUID.getUUID(),
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
  @override
  ModelType<Model> getInstanceType() => classType;

  static const QueryModelIdentifier<TodoModelIdentifier> MODEL_IDENTIFIER =
      QueryModelIdentifier<TodoModelIdentifier>();
  static const ID = QueryField(fieldName: 'id');
  static const NAME = QueryField(fieldName: 'name');
  static const DESCRIPTION = QueryField(fieldName: 'description');
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = 'Todo';
    modelSchemaDefinition.pluralName = 'Todos';

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string),
    ));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.DESCRIPTION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string),
    ));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime),
    ));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime),
    ));
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  @override
  String toString() =>
      'Todo { id: $id, name: $name, description: $description, '
      'createdAt: $createdAt, updatedAt: $updatedAt }';

  Todo copyWith({
    String? id,
    String? name,
    String? description,
    TemporalDateTime? createdAt,
    TemporalDateTime? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt?.format(),
      'updatedAt': updatedAt?.format(),
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: json['createdAt'] != null
          ? TemporalDateTime.fromString(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? TemporalDateTime.fromString(json['updatedAt'] as String)
          : null,
    );
  }
}

class _TodoModelType extends ModelType<Todo> {
  const _TodoModelType();

  @override
  Todo fromJson(Map<String, dynamic> jsonData) {
    return Todo.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'Todo';
  }
}

class TodoModelIdentifier implements ModelIdentifier<Todo> {
  final String id;

  const TodoModelIdentifier({required this.id});

  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
      .entries
      .map((entry) => (<String, dynamic>{entry.key: entry.value}))
      .toList();

  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{'id': id});

  @override
  String serializeAsString() => serializeAsMap().values.join('#');

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is TodoModelIdentifier && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
