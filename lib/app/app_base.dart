import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordersaman/app/app_themes.dart';
import 'package:ordersaman/common/constants/constant.dart';
import 'package:ordersaman/common/cubit/theme_cubit.dart';
import 'package:ordersaman/common/routes/routes.dart';
import 'package:ordersaman/common/routes/routes_generator.dart';
import 'package:ordersaman/common/utils/navigation_service.dart';

class BaseApp extends StatefulWidget {
  final Widget Function(BuildContext, Widget?)?
  builder; // ✅ Allow custom builder

  const BaseApp({super.key, this.builder});

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  late ThemeCubit _themeCubit;

  @override
  void initState() {
    super.initState();
    _themeCubit = ThemeCubit();
    _loadTheme();
  }

  void _loadTheme() async {
    final savedTheme = await ThemeCubit.getSavedTheme();
    _themeCubit.setTheme(savedTheme);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _themeCubit,
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            locale: context.locale,
            navigatorKey: NavigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: Constants.appTitle,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeMode,
            initialRoute: Routes.root,
            onGenerateRoute: RouteGenerator.generateRoute,
            builder: widget.builder,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
          );
        },
      ),
    );
  }
}
