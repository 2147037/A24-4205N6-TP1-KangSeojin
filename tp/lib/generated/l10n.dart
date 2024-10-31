// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Register`
  String get inscription {
    return Intl.message(
      'Register',
      name: 'inscription',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nom {
    return Intl.message(
      'Name',
      name: 'nom',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get crerTonCompte {
    return Intl.message(
      'Create account',
      name: 'crerTonCompte',
      desc: '',
      args: [],
    );
  }

  /// `Connection`
  String get connexion {
    return Intl.message(
      'Connection',
      name: 'connexion',
      desc: '',
      args: [],
    );
  }

  /// `Add Task`
  String get creation {
    return Intl.message(
      'Add Task',
      name: 'creation',
      desc: '',
      args: [],
    );
  }

  /// `Enter the date`
  String get dateInput {
    return Intl.message(
      'Enter the date',
      name: 'dateInput',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get create {
    return Intl.message(
      'Add',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get consultation {
    return Intl.message(
      'Details',
      name: 'consultation',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Deadline`
  String get deadline {
    return Intl.message(
      'Deadline',
      name: 'deadline',
      desc: '',
      args: [],
    );
  }

  /// `Percentage Done`
  String get percentageDone {
    return Intl.message(
      'Percentage Done',
      name: 'percentageDone',
      desc: '',
      args: [],
    );
  }

  /// `Percentage Time Spent`
  String get percentageTimeSpent {
    return Intl.message(
      'Percentage Time Spent',
      name: 'percentageTimeSpent',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get modifier {
    return Intl.message(
      'Edit',
      name: 'modifier',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get accueil {
    return Intl.message(
      'Home',
      name: 'accueil',
      desc: '',
      args: [],
    );
  }

  /// `The connection is not active.`
  String get laConnexionNestPasActive {
    return Intl.message(
      'The connection is not active.',
      name: 'laConnexionNestPasActive',
      desc: '',
      args: [],
    );
  }

  /// `The passwords does not match.`
  String get lesMotsDePasseNeSeConcordentPas {
    return Intl.message(
      'The passwords does not match.',
      name: 'lesMotsDePasseNeSeConcordentPas',
      desc: '',
      args: [],
    );
  }

  /// `Add an image !!!`
  String get ajouteUneImage {
    return Intl.message(
      'Add an image !!!',
      name: 'ajouteUneImage',
      desc: '',
      args: [],
    );
  }

  /// `Send image`
  String get envoyerImage {
    return Intl.message(
      'Send image',
      name: 'envoyerImage',
      desc: '',
      args: [],
    );
  }

  /// `You are not connected cawliss`
  String get tuNesToujoursPasConnect {
    return Intl.message(
      'You are not connected cawliss',
      name: 'tuNesToujoursPasConnect',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr', countryCode: 'CA'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
