---
name: add-json-model
description: Create a JSON-serializable data model for the mh_salun Flutter app. Use when adding a model/DTO/entity that maps to or from an API payload, parsing a response body, or mapping snake_case API fields to Dart. Covers json_serializable annotations, part files, build_runner codegen, and @JsonKey field mapping.
---

# Add a JSON model

Packages: `json_annotation` (runtime) + `json_serializable` + `build_runner` (dev).
Models are plain Dart classes annotated `@JsonSerializable`; the generated
`*.g.dart` file holds `fromJson`/`toJson` and is committed alongside the source.

## Where it goes
`lib/features/<feature>/data/<model>.dart` (models live in the data layer).

## Create a model
```dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;

  @JsonKey(name: 'display_name') // map snake_case API field -> Dart name
  final String name;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

## Run codegen (required after adding/editing any model)
```bash
dart run build_runner build --delete-conflicting-outputs   # one-off
dart run build_runner watch                                 # regenerate on save
```

## Checklist
- [ ] `part '<file>.g.dart';` directive present
- [ ] `fromJson`/`toJson` wired to generated `_$...` functions
- [ ] `@JsonKey(name: ...)` for any API field that isn't already the Dart name
- [ ] Ran `build_runner`; committed the generated `*.g.dart`

This skill is usually invoked by **add-repo** (for the repo's request/response types)
and by **build-data-layer**.
