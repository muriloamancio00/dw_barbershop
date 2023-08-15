import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  var _scale =10;
  // quando a tela é construida ela vem sem cor, e quando constroi ela recebe o valor se alterando
  var _animationOpacityLogo =0.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      setState(() {
        _animationOpacityLogo = 1.0;
      });
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background_image_chair.jpg',
              ),
              opacity: 0.2,
              fit: BoxFit.cover
            ),
          ),
          child: Center(
            child: AnimatedOpacity(
              duration: const Duration(seconds: 3),
              curve: Curves.easeIn,
              opacity: _animationOpacityLogo,
              child: Image.asset('assets/images/imgLogo.png')
            ),
          ),
      ),
    );
  }
}
