// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accueil": MessageLookupByLibrary.simpleMessage("Home"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "connexion": MessageLookupByLibrary.simpleMessage("Connection"),
        "consultation": MessageLookupByLibrary.simpleMessage("Details"),
        "create": MessageLookupByLibrary.simpleMessage("Add"),
        "creation": MessageLookupByLibrary.simpleMessage("Add Task"),
        "crerTonCompte": MessageLookupByLibrary.simpleMessage("Create account"),
        "dateInput": MessageLookupByLibrary.simpleMessage("Enter the date"),
        "deadline": MessageLookupByLibrary.simpleMessage("Deadline"),
        "details": MessageLookupByLibrary.simpleMessage("Details"),
        "inscription": MessageLookupByLibrary.simpleMessage("Register"),
        "modifier": MessageLookupByLibrary.simpleMessage("Edit"),
        "nom": MessageLookupByLibrary.simpleMessage("Name"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "percentageDone":
            MessageLookupByLibrary.simpleMessage("Percentage Done"),
        "percentageTimeSpent":
            MessageLookupByLibrary.simpleMessage("Percentage Time Spent")
      };
}
