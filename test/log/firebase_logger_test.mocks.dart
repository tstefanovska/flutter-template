// Mocks generated by Mockito 5.0.5 from annotations
// in flutter_template/test/log/firebase_logger_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:firebase_core/firebase_core.dart' as _i2;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i3;
import 'package:flutter/src/foundation/assertions.dart' as _i6;
import 'package:flutter/src/foundation/diagnostics.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeFirebaseApp extends _i1.Fake implements _i2.FirebaseApp {}

/// A class which mocks [FirebaseCrashlytics].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseCrashlytics extends _i1.Mock
    implements _i3.FirebaseCrashlytics {
  MockFirebaseCrashlytics() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FirebaseApp get app => (super.noSuchMethod(Invocation.getter(#app),
      returnValue: _FakeFirebaseApp()) as _i2.FirebaseApp);
  @override
  set app(_i2.FirebaseApp? _app) =>
      super.noSuchMethod(Invocation.setter(#app, _app),
          returnValueForMissingStub: null);
  @override
  bool get isCrashlyticsCollectionEnabled =>
      (super.noSuchMethod(Invocation.getter(#isCrashlyticsCollectionEnabled),
          returnValue: false) as bool);
  @override
  Map<dynamic, dynamic> get pluginConstants =>
      (super.noSuchMethod(Invocation.getter(#pluginConstants),
          returnValue: <dynamic, dynamic>{}) as Map<dynamic, dynamic>);
  @override
  _i4.Future<bool> checkForUnsentReports() =>
      (super.noSuchMethod(Invocation.method(#checkForUnsentReports, []),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  void crash() => super.noSuchMethod(Invocation.method(#crash, []),
      returnValueForMissingStub: null);
  @override
  _i4.Future<void> deleteUnsentReports() =>
      (super.noSuchMethod(Invocation.method(#deleteUnsentReports, []),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<bool> didCrashOnPreviousExecution() =>
      (super.noSuchMethod(Invocation.method(#didCrashOnPreviousExecution, []),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  _i4.Future<void> recordError(dynamic exception, StackTrace? stack,
          {dynamic reason,
          Iterable<_i5.DiagnosticsNode>? information = const [],
          bool? printDetails,
          bool? fatal = false}) =>
      (super.noSuchMethod(
          Invocation.method(#recordError, [
            exception,
            stack
          ], {
            #reason: reason,
            #information: information,
            #printDetails: printDetails,
            #fatal: fatal
          }),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> recordFlutterError(
          _i6.FlutterErrorDetails? flutterErrorDetails) =>
      (super.noSuchMethod(
          Invocation.method(#recordFlutterError, [flutterErrorDetails]),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> log(String? message) =>
      (super.noSuchMethod(Invocation.method(#log, [message]),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> sendUnsentReports() =>
      (super.noSuchMethod(Invocation.method(#sendUnsentReports, []),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> setCrashlyticsCollectionEnabled(bool? enabled) =>
      (super.noSuchMethod(
          Invocation.method(#setCrashlyticsCollectionEnabled, [enabled]),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> setUserIdentifier(String? identifier) =>
      (super.noSuchMethod(Invocation.method(#setUserIdentifier, [identifier]),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> setCustomKey(String? key, Object? value) =>
      (super.noSuchMethod(Invocation.method(#setCustomKey, [key, value]),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
}
