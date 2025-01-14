import 'package:flutter/services.dart';
import 'package:flutter_template/log/logger.dart';
import 'package:flutter_template/platform_comm/item_converter.dart';
import 'package:flutter_template/platform_comm/platform_callback.dart';
import 'package:flutter_template/util/subscription.dart';

export 'app_platform_methods.dart';

/// Global platform communication for app actions that don't require a plugin.
///
/// Note: Needs to be singleton otherwise it will overwrite the [MethodChannel].
///
/// To obtain an instance use `serviceLocator.get<PlatformComm>()`
class PlatformComm {
  final MethodChannel _methodChannel;
  final Map<String, PlatformCallbackRaw> _platformCallbackMap = Map();

  factory PlatformComm.globalAppChannel() => PlatformComm(MethodChannel(
      'com.my-app.package-name.global')); //todo change channel name

  factory PlatformComm.onChannel(String channelName) =>
      PlatformComm(MethodChannel(channelName));

  PlatformComm(this._methodChannel) {
    _methodChannel.setMethodCallHandler((call) {
      Logger.d('Platform callback: ${call.method} w/ args ${call.arguments}');
      return _platformCallbackMap[call.method]?.call(call.arguments) ??
          Future.error(MissingPluginException('No method found'));
    });
  }

  /// Invokes a platform method with or without parameters
  /// and expects a result.
  Future<R> invokeMethod<R, P>({
    required String method,
    P? param,
    Serialize<P>? serializeParams,
    Deserialize<R>? deserializeResult,
  }) =>
      _methodChannel
          .invokeMethod(method,
              param != null ? (serializeParams?.call(param) ?? param) : [])
          .then((data) => deserializeResult?.call(data) ?? data);

  /// Like invoke method, but it doesn't expect a result.
  Future<void> invokeProcedure<P>({
    required String method,
    P? param,
    Serialize<P>? serializeParams,
  }) =>
      _methodChannel.invokeMethod(
          method, param != null ? (serializeParams?.call(param) ?? param) : []);

  /// Listens for the specified [method] to be invoked
  /// overwriting any previously registered listeners.
  ///
  /// Provide [callback] to be invoked from the platform side
  /// with param [P] and provide [deserializeParams] for converting
  /// the raw `dynamic` params to [P]. If [deserializeParams] is
  /// not provided the raw params are cast to [P].
  ///
  /// The result from the [callback] is returned to the invoking
  /// component on the platform side.
  Subscription listenMethod<P>({
    required String method,
    required PlatformCallback<P> callback,
    Deserialize<P>? deserializeParams,
  }) {
    _platformCallbackMap[method] = (paramsRaw) =>
        callback(deserializeParams?.call(paramsRaw) ?? paramsRaw as P);

    return Subscription(cancel: () => _platformCallbackMap.remove(method));
  }

  /// Like [listenMethod] but without params.
  Subscription listenMethodNoParams<P>({
    required String method,
    required PlatformCallbackNoParams callback,
  }) {
    _platformCallbackMap[method] = (_) => callback();

    return Subscription(cancel: () => _platformCallbackMap.remove(method));
  }
}
