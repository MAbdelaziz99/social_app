import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/bloc_observer.dart';
import 'package:social_app/presentation/login/cubit/login_cubit.dart';
import 'package:social_app/presentation/register/cubit/register_cubit.dart';
import 'package:social_app/presentation/splash/splash_screen.dart';
import 'package:social_app/router/app_router.dart';
import 'package:social_app/shared/style/colors.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<RegisterCubit>(
            create: (context) => RegisterCubit(),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(),
          ),
        ],
        child: MaterialApp(
          home: const SplashScreen(),
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 1.0,
              centerTitle: true,
              iconTheme: IconThemeData(color: darkGreyColor),
              actionsIconTheme: IconThemeData(color: darkGreyColor),
            ),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (settings) =>
              AppRouter.get().generateRoute(settings),
        ),
      ),
    );
  }
}
