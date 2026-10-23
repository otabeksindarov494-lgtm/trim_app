import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:trim_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:trim_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:trim_app/features/auth/data/repositories/auth_repository.dart';
import 'package:trim_app/features/salon/presentation/bloc/salon_bloc.dart';
import 'package:trim_app/core/l10n/app_localizations.dart';
import 'package:trim_app/core/l10n/language_cubit.dart';
import 'package:trim_app/core/theme/theme_cubit.dart';
import 'package:trim_app/theme/app_theme.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/features/profile/data/repositories/profile_repository.dart';
import 'package:trim_app/features/salon/data/repositories/salon_repository.dart';
import 'package:trim_app/core/router/app_router.dart';
import 'package:trim_app/widgets/common/glass.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background message received: ${message.messageId}");
}

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // Set background messaging handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Request permission and retrieve FCM token
  try {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await FirebaseMessaging.instance.getToken();
      print("FCM Token: $token");
    }
  } catch (e) {
    print("FCM initialization error: $e");
  }

  await initializeDateFormatting('ru_RU');
  await initializeDateFormatting('uz_UZ');
  final List<ListImage> imageList = [
    ListImage(
      image: 'assets/images/img_56.png',
      title: 'Стрижка & Укладка',
      subTitle: 'Действует до 20 Дек 2024',
      sum: '50 000 UZS',
    ),
    ListImage(
      image: 'assets/images/img_57.png',
      title: 'Beauty Make Up',
      subTitle: 'Действует до 20 Дек 2024',
      sum: '50 000 UZS',
    ),
    ListImage(
      image: 'assets/images/img_58.png',
      title: 'Стрижка & Покраска',
      subTitle: 'Действует до 20 Дек 2024',
      sum: '50 000 UZS',
    ),
    ListImage(
      image: 'assets/images/img_59.png',
      title: 'Стрижка & Бритье',
      subTitle: 'Действует до 20 Дек 2024',
      sum: '50 000 UZS',
    ),
  ];

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(repository: AuthRepository()),
        ),
        BlocProvider(
          create: (_) => ProfileBloc(repository: ProfileRepository()),
        ),
        BlocProvider(
          create: (_) => SalonBloc(repository: SalonRepository()),
        ),
        BlocProvider(
          create: (_) => LanguageCubit(),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: MyApp(imageList: imageList),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.imageList});

  final List<ListImage> imageList;
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return ScreenUtilInit(
              designSize: const Size(411, 923),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp.router(
                  routerConfig: appRouter.config(),
                  locale: locale,
                  themeMode: themeMode,
                  theme: AppTheme.light,
                  darkTheme: AppTheme.dark,
                  supportedLocales: const [
                    Locale('uz'),
                    Locale('ru'),
                  ],
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(
                        context,
                      ).copyWith(textScaler: TextScaler.noScaling),
                      child: GlassBackground(child: child!),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
