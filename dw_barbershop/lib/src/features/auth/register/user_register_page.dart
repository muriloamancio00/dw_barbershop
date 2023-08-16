import 'package:dw_barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:dw_barbershop/src/features/auth/register/user_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/helpers/messages.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  //statless para consumer statefulwidget
  //state para consumerstate
//para assim poder usar o ref e deixar escutar o provider notifier, watch ..
  const UserRegisterPage({ super.key });

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {
//registros de cadastro
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

   @override
   Widget build(BuildContext context) {

    final userRegisterVm = ref.watch(userRegisterVmProvider.notifier);

    ref.listen(userRegisterVmProvider,(_,state){
      switch(state){
        case UserRegisterStateStatus.initial:
          break;
        case UserRegisterStateStatus.success:
          Navigator.of(context).pushNamed('/auth/rtegister/barbershop');
        case UserRegisterStateStatus.error:
          Messages.showError('Erro ao registrar usuário administrador', context);
      }
    });
       return Scaffold(
           appBar: AppBar(title:  const Text('Criar Conta'),),
           body:   Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                   TextFormField(
                    onTapOutside: (_) => context.unfocus(),
                    controller: nameEC,
                    validator: Validatorless.required('Nome obrigatório'),
                    decoration: const InputDecoration(
                      label: Text('Nome'),
                    ),
                  ),
                  const SizedBox(
                     height: 24,
                  ),
                   TextFormField(
                    onTapOutside: (_) => context.unfocus(),
                    controller: emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail obrigatório'),
                      Validatorless.email('E-mail- inválido'),
                    ]),
                    decoration: const InputDecoration(
                      label: Text('E-mail'),
                    ),
                  ),
                   const SizedBox(
                     height: 24,
                  ),
                   TextFormField(
                    onTapOutside: (_) => context.unfocus(),
                    controller: passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatório'),
                      Validatorless.min(6, 'Senha deve ter no minimo 6 caracteres'),
                    ]),
                    obscureText: true,
                    decoration: const InputDecoration(
                      label: Text('Senha'),
                    ),
                  ),
                    const SizedBox(
                     height: 24,
                  ),
                   TextFormField(
                    onTapOutside: (_) => context.unfocus(),
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirmar senha obrigatório'),
                      Validatorless.compare(passwordEC, 'Senha diferente de confirma senha'),
                    ]),
                    decoration: const InputDecoration(
                      label: Text('Confirmar Senha'),
                    ),
                  ),
                  const SizedBox(
                     height: 24,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                  onPressed: () {
                    switch(formKey.currentState?.validate()){
                      case null || false:
                        Messages.showError('Formulario inválido', context);
                      case true:
                        userRegisterVm.register(
                          name: nameEC.text, 
                          email: emailEC.text, 
                          password: passwordEC.text
                        );
                    }
                  },
                   child: const Text('CRIAR CONTA')),
                  ],
                ),
              ),
            ),
           ),
       );
  }
}