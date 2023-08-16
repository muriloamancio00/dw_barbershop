import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/features/auth/login/login_state.dart';
import 'package:dw_barbershop/src/features/auth/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends ConsumerStatefulWidget {

  const LoginPage({ super.key });

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

   @override
   Widget build(BuildContext context) {

    //usado assim caso fosse precisar apenas do estado atual, mas o interessante
    //é ter o acesso a view model atual, classe e chamando o methodo de login
    //final loginVM = ref.watch(loginVmProvider);
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);

    ref.listen(loginVmProvider, (_, state){
      switch(state){
          case LoginState(status: LoginStateStatus.initial):
            break;
          case LoginState(status: LoginStateStatus.error, :final errorMessage?):
            Messages.showError(errorMessage, context);
          case LoginState(status: LoginStateStatus.error):
            Messages.showError('Erro ao realizar login', context);
          case LoginState(status: LoginStateStatus.admLogin):
            Navigator.of(context).pushNamedAndRemoveUntil('/home/adm',(route) => false);
            break;
          case LoginState(status: LoginStateStatus.employeeLogin):
            Navigator.of(context).pushNamedAndRemoveUntil('/home/employee',(route) => false);
            break;

      }
    });

       return  Scaffold(
        backgroundColor: Colors.black,
        body: Form(
          key: formKey,
          child: DecoratedBox(
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
                                onTapOutside: (_) => context.unfocus(),
                                validator: Validatorless.multiple([
                                  Validatorless.required('E-mail obrigatório'),
                                  Validatorless.required('E-mail invalido'),
                                ]),
                                controller: emailEC,
                                decoration: const InputDecoration(
                                  // com hintText nao é necessario label
                                  label: Text('E-mail'),
                                  // fazendo com que o login desapareca so quando for digitado algo
                                  hintText: 'E-mail',
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
                                onTapOutside: (_) => context.unfocus(),
                                validator: Validatorless.multiple([
                                  Validatorless.required('password obrigatório'),
                                  Validatorless.min(6,'password deve conter pelo menos 6 caracteres'),
                                ]),
                                controller: passwordEC,
                                obscureText: true,
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
                                onPressed: (){
                                  switch(formKey.currentState?.validate()){
                                    case(false || null) :
                                      // Mostrar uma mensagem de erro campos invalidos
                                      Messages.showError('Campos inválidos', context);
                                      break;
                                    case true:
                                      login(emailEC.text, passwordEC.text);
                                  }
                                }, 
                                child: const Text('ACESSAR')
                              ),
                            ],
                          ),
                           Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed('/auth/register/user');
                              } ,
                              child: const Text('Criar conta', 
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white, 
                                fontWeight: FontWeight.w500
                                ),
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
        ),
       );
  }
}