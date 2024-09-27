import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'transfer.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class SignupRequest {
  SignupRequest(this.username, this.password);

  String username;
  String password;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SignupRequest.fromJson(Map<String, dynamic> json) => _$SignupRequestFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}

@JsonSerializable()
class SignupResponse {
  SignupResponse(this.username);

  String username;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SignupResponse.fromJson(Map<String, dynamic> json) => _$SignupResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}

@JsonSerializable()
class HomeItemResponse {
  HomeItemResponse(this.id, this.name ,this.percentageDone, this.percentageTimeSpent, this.deadline);

  int id;
  String name;
  int percentageDone;
  double percentageTimeSpent;
  DateTime deadline;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory HomeItemResponse.fromJson(Map<String, dynamic> json) => _$HomeItemResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$HomeItemResponseToJson(this);
}

@JsonSerializable()
class AddTaskRequest {
  AddTaskRequest(this.name ,this.deadline);

  String name;
  DateTime deadline;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory AddTaskRequest.fromJson(Map<String, dynamic> json) => _$AddTaskRequestFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$AddTaskRequestToJson(this);
}

@JsonSerializable()
class TaskDetailResponse {
  TaskDetailResponse(this.id, this.name ,this.percentageDone, this.percentageTimeSpent, this.deadline);

  int id;
  String name;
  DateTime deadline;
  int percentageDone;
  double percentageTimeSpent;


  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory TaskDetailResponse.fromJson(Map<String, dynamic> json) => _$TaskDetailResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TaskDetailResponseToJson(this);
}
