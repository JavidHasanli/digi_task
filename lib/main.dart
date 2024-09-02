import 'package:digi_task/app_router.dart';
import 'package:digi_task/location/location_service.dart';
import 'package:digi_task/notifier/auth/auth_notifier.dart';
import 'package:digi_task/notifier/home/main/main_notifier.dart';
import 'package:digi_task/notifier/theme/theme_scope.dart';
import 'package:digi_task/notifier/theme/theme_scope_widget.dart';
import 'package:digi_task/presentation/pages/notification/notification_cubit.dart';
import 'package:digi_task/presentation/pages/notification/services/websocket.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'injection.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:digi_task/data/services/local/secure_service.dart';
import 'dart:async';

class WebSocketManager {
  final SecureService secureService = SecureService(
    secureStorage: const FlutterSecureStorage(),
  );

  WebSocketChannel? channel;
  Timer? _locationTimer;

  Future<void> connectWebSocket() async {
    final token = await secureService.accessToken;

    channel = WebSocketChannel.connect(
      Uri.parse('ws://135.181.42.192/ws/?token=$token'),
    );

    channel!.stream.listen(
      (event) {
        print('Received raw WebSocket message: $event');
        try {
          final data = jsonDecode(event);
          print('Parsed WebSocket message: $data');
        } catch (e) {
          print('Error parsing WebSocket message: $e');
        }
      },
      onError: (error) {
        print('WebSocket error: $error');
      },
      onDone: () {
        print('WebSocket connection closed');
        Future.delayed(const Duration(seconds: 5), () {
          connectWebSocket();
        });
      },
    );
  }

  void closeWebSocket() {
    print('socket closed brooooooooooooooooo');
    _locationTimer?.cancel();
    channel?.sink.close();
  }

  void startLocationTimer(double latitude, double longitude) {
    _locationTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      sendLocation(latitude, longitude);
    });
  }

  void sendLocation(double latitude, double longitude) {
    if (channel != null && channel!.sink != null) {
      final location = {
        'latitude': latitude,
        'longitude': longitude,
      };
      channel!.sink.add(jsonEncode({'location': location}));
    } else {
      print('WebSocket is not connected.');
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  final locationService = LocationService();
  await locationService.startGettingLocation();

  final webSocketManager = WebSocketManager();
  await webSocketManager.connectWebSocket();

  final webSocketService = WebSocketService();
  await webSocketService.connectWebSocket();

  Future.delayed(const Duration(seconds: 10), () async {
    if (webSocketManager.channel != null) {
      await locationService.startGettingLocation();
      print('WebSocket is connected. Starting location timer.');
      print(locationService.currentPosition!.latitude);
      print(locationService.currentPosition!.longitude);
      webSocketManager.startLocationTimer(
          locationService.currentPosition!.latitude,
          locationService.currentPosition!.longitude);
    } else {
      await webSocketManager.connectWebSocket();
      print('WebSocket connection failed.');
    }
  });

  print('-----------');
  if (locationService.currentPosition != null) {
    print('Enlem: ${locationService.currentPosition!.latitude}');
    print('Boylam: ${locationService.currentPosition!.longitude}');
  } else {
    print('Konum verisi alınamadı.');
  }

  print("Current Position: ${locationService.currentPosition}");
  print("Current Address: ${locationService.currentAddress}");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => GetIt.instance<AuthNotifier>()),
        ChangeNotifierProvider(
            create: (context) => GetIt.instance<MainNotifier>()),
        ChangeNotifierProvider(create: (_) => locationService),
        BlocProvider<NotificationCubit>(create: (_) => NotificationCubit()),
      ],
      child: const ThemeScopeWidget(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeScope.of(context);
    final extensions = <ThemeExtension<dynamic>>[
      theme.appColors,
      theme.appTypography
    ];
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp.router(
      locale: const Locale('az'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Digi Task',
      theme: ThemeData(
        extensions: extensions,
      ),
      routerConfig: GetIt.instance.get<AppRouter>().instance,
    );
  }
}

