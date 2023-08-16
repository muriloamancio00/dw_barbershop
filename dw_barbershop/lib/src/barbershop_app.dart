import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:dw_barbershop/src/features/auth/login/login_page.dart';
import 'package:dw_barbershop/src/features/splash/splash_page.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {

  const BarbershopApp({ super.key });

   @override
   Widget build(BuildContext context) {
       return AsyncStateBuilder(builder: (asyncNavigatorObserver) {
         return MaterialApp(
          title: 'DW Barbershop',
          theme: BarbershopTheme.themeData,
          // o riverpod realiza algumas açoes antes do build da tela
          navigatorObservers: [asyncNavigatorObserver],
          navigatorKey: BarbershopNavGlobalKey.instance.navKey,
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),  
            '/home/adm':(_) => const Text('ADM'),  
            '/home/employee':(_) => const Text('Employee'),  
          },
         );
       },
      );
    }
  }