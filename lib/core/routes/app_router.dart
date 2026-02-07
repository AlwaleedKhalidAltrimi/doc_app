import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/auth/presentation/providers/log_in_provider.dart';
import '../../features/auth/presentation/providers/sign_up_provider.dart';
import '../../features/auth/presentation/views/log_in_view.dart';
import '../../features/auth/presentation/views/sign_up_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/on_boarding/presentation/views/on_boarding_view.dart';
import '../di/dependency_injection.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingView:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.logInView:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => getIt<LoginProvider>(),
            child: const LoginView(),
          ),
        );

      case Routes.signUpView:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => getIt<SignupProvider>(),
            child: const SignUpView(),
          ),
        );
      case Routes.homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
