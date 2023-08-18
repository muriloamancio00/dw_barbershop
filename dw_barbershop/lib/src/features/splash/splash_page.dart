import 'dart:async';
import 'dart:developer';

import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/features/splash/splash_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {

  var _scale =10.0;
  // quando a tela é construida ela vem sem cor, e quando constroi ela recebe o valor se alterando
  var _animationOpacityLogo =0.0;

  //metodos auxiliares para efeito de entrada da logo
  double get _logoAnimationWidth => 100 * _scale;
  double get _logoAnimationHeight => 120 * _scale;

  var endAnimation = false;

  Timer? redirectTimer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1;
      });
    });
    super.initState();
  }

//pare serolver a questao do redirect, isso tem que ser executado a todo momento
//usando temporizador e recursao, a cada 3 segundos
  void _redirect(String routeName) {
    if(!endAnimation){
      redirectTimer?.cancel();
      redirectTimer = Timer(const Duration(milliseconds: 300), () {
        _redirect(routeName);
      });
    }else{
      redirectTimer?.cancel();
      Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
    }

  }

  //state async value, ganhando alguns metodos do when
  @override
  Widget build(BuildContext context) {
    ref.listen(splashVmProvider, (_, state) {
      state.whenOrNull(
        error: (error, stackTrace) {
          log('Erro ao validar o login', error: error, stackTrace: stackTrace);
          Messages.showError('Erro ao validar o login', context);
          _redirect('/auth/login');
        },
        data:(data){
          //listner
          switch (data) {
            case SplashState.loggedADM:
              _redirect('/home/adm');
            case SplashState.loggedEmployee:
              _redirect('/home/employee');
            case _:
              _redirect('/auth/login');
          }
        },
      );
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ImageConstants.backgroundChair,
              ),
              opacity: 0.2,
              fit: BoxFit.cover
            ),
          ),
          child: Center(
            child: AnimatedOpacity(
              duration: const Duration(seconds: 2),
              curve: Curves.easeIn,
              opacity: _animationOpacityLogo,
              onEnd: (){
                setState(() {
                  endAnimation = true;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(seconds: 3),
                width: _logoAnimationWidth,
                height: _logoAnimationHeight,
                curve: Curves.linearToEaseOut,
                child: Image.asset(ImageConstants.imageLogo, fit:BoxFit.cover)
              )
            ),
          ),
      ),
    );
  }
}
