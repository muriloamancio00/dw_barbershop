import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_barbershop/features/auth/login/login_page.dart';
import 'package:dw_barbershop/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {

  const BarbershopApp({ super.key });

   @override
   Widget build(BuildContext context) {
       return AsyncStateBuilder(builder: (asyncNavigatorObserver) {
         return MaterialApp(
          title: 'DW Barbershop',
          // o riverpod realiza algumas açoes antes do build da tela
          navigatorObservers: [asyncNavigatorObserver],
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),  
          },
         );
       },
      );
    }
  }