import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/app_routes.dart';
import 'package:flutter_template/config/flavor_config.dart';
import 'package:flutter_template/di/service_locator.dart';
import 'package:flutter_template/feature/auth/login/login_page.dart';
import 'package:flutter_template/feature/home/home_page.dart';
import 'package:flutter_template/resources/strings.dart';
import 'package:flutter_template/util/app_lifecycle_observer.dart';
import 'package:flutter_template/widgets/circular_progress_indicator.dart';
import 'package:package_info/package_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'feature/auth/global_handler/global_auth_cubit.dart';
import 'feature/auth/global_handler/global_auth_state.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

//todo replace state with flutter hooks

class _AppState extends State<App> {
  String _buildVersion = '';

  Future<void> _getBuildVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _buildVersion =
          'Build version ${packageInfo.version} (${packageInfo.buildNumber})';
    });
  }

  @override
  void initState() {
    super.initState();
    serviceLocator.get<AppLifecycleObserver>().activate();

    if (!FlavorConfig.isProduction()) {
      _getBuildVersion();
    }
  }

  @override
  void dispose() {
    serviceLocator.get<AppLifecycleObserver>().deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'NotoSansJP',
      ),
      localizationsDelegates: [
        RefreshLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        const LocalizedStringsDelegate(['en', 'mk'],
            fallbackLocale: const Locale('en')),
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('mk'), // Macedonian
      ],
      navigatorObservers: [],
      //todo maybe add navigation observer here
      routes: {
        Routes.home: (context) => HomePage(),
        Routes.login: (context) => LoginPage(),
        // Routes.signUp: (context) => SignUpPage(),
        // Routes.signUpSuccess: (context) => SignUpSuccessPage(),
      },
      home: BlocConsumer<GlobalAuthCubit, GlobalAuthState>(
        listener: (listenerContext, state) {
          if (state is AuthenticationFailure) {
            Navigator.popUntil(
                listenerContext, (Route<dynamic> route) => route.isFirst);
          }
        },
        builder: (context, state) {
          if (!FlavorConfig.isProduction()) {
            WidgetsBinding.instance?.addPostFrameCallback(
                (_) => _insertOverlay(context, _buildVersion));
          }

          if (state is AuthenticationSuccess) {
            return HomePage();
          } else if (state is AuthenticationFailure) {
            return LoginPage(sessionExpiredRedirect: state.sessionExpired);
          } else {
            return Scaffold(
              body: BasicCircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _insertOverlay(BuildContext context, buildVersion) {
    Overlay.of(context)?.insert(
      OverlayEntry(builder: (context) {
        var safePadding = MediaQuery.of(context).padding.bottom;
        final size = MediaQuery.of(context).size;
        final textSize = (TextPainter(
                text: TextSpan(
                    text: buildVersion,
                    style: Theme.of(context).textTheme.caption),
                maxLines: 1,
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                textDirection: TextDirection.ltr)
              ..layout())
            .size;

        return Positioned(
          height: 56,
          top: size.height - max(safePadding, 20),
          left: (size.width - textSize.width) / 2,
          child: IgnorePointer(
            child: Text(
              buildVersion,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        );
      }),
    );
  }
}
