import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({ super.key });

   @override
   Widget build(BuildContext context) {
       return  Scaffold(
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
            // usado quando tem necessidade de esticar/usar a tela inteira, no caso por conta do "criar conta"
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          // tudo que é colocado na tela inicia no centro
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(ImageConstants.imageLogo),
                            const SizedBox(
                               height: 24,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                // com hintText nao é necessario label
                                label: Text('Login'),
                                // fazendo com que o login desapareca so quando for digitado algo
                                hintText: 'Login',
                                //caso possua label - para ele nunca subir, tirando o bug do label acima do input
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                hintStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                               height: 24,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                label: Text('password'),
                                // fazendo com que o login desapareca so quando for digitado algo
                                hintText: 'password',
                                //caso possua label - para ele nunca subir, tirando o bug do label acima do input
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                hintStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                               height: 16,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Esqueceu a senha?', 
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorsConstants.brow,
                                ),
                              ),
                            ),
                            const SizedBox(
                               height: 24,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize:  const Size.fromHeight(56),
                              ),
                              onPressed: (){}, 
                              child: const Text('ACESSAR')
                            ),
                          ],
                        ),
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('Criar conta', 
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white, 
                            fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
        ),
       );
  }
}