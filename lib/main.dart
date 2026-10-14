import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:trim_app/auth_bloc/auth_bloc.dart';
import 'package:trim_app/bloc/provider/profile_bloc.dart';
import 'package:trim_app/bloc/provider/repository/auth_repository.dart';
import 'package:trim_app/bloc/salon_bloc/salon_bloc.dart';
import 'package:trim_app/l10n/app_localizations.dart';
import 'package:trim_app/l10n/language_cubit.dart';
import 'package:trim_app/profile/action_page.dart';
import 'bloc/provider/repository/profile_repository.dart';
import 'bloc/provider/repository/salon_repository.dart';
import 'router/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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
        return ScreenUtilInit(
          designSize: const Size(411, 923),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              routerConfig: appRouter.config(),
              locale: locale,
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
                  child: child!,
                );
              },
            );
          },
        );
      },
    );
  }
}
