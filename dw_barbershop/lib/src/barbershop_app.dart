import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:dw_barbershop/src/features/auth/login/login_page.dart';
import 'package:dw_barbershop/src/features/auth/register/barbershop/barbershop_register_page.dart';
import 'package:dw_barbershop/src/features/employee/register/employee_register_page.dart';
import 'package:dw_barbershop/src/features/employee/schedule/employee_schedule_page.dart';
import 'package:dw_barbershop/src/features/home/adm/home_adm_page.dart';
import 'package:dw_barbershop/src/features/schedule/schedule_page.dart';
import 'package:dw_barbershop/src/features/splash/splash_page.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:flutter/material.dart';

import 'features/auth/register/user/user_register_page.dart';

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
            '/auth/register/user': (_) => const UserRegisterPage(),  
            '/auth/rtegister/barbershop': (_) => const BarbershopRegisterPage(),  
            '/home/adm':(_) => const HomeAdmPage(),  
            '/home/employee':(_) => const Text('Employee'),  
            '/employee/register':(_) => const EmployeeRegisterPage(),  
            '/employee/schedule':(_) => const EmployeeSchedulePage(),  
            '/schedule':(_) => const SchedulePage(),  
          },
         );
       },
      );
    }
  }