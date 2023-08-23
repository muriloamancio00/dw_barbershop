import 'package:dw_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:dw_barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:flutter/material.dart';

class EmployeeRegisterPage extends StatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  State<EmployeeRegisterPage> createState() => _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends State<EmployeeRegisterPage> {
  //definição da key state da pagina
  var registerAdm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Colaborador'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                const AvatarWidget(),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    //nosso botao que controla o state
                    Checkbox.adaptive(value: registerAdm, onChanged: (value) {
                      setState(() {
                        registerAdm = !registerAdm;
                      });
                    }),
                    const Expanded(
                      //envolvendo o text no expanded, ele quebra para baixo
                      child: Text(
                        'Sou administrador e quero me cadastrar como Colaborador',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Offstage(
                  //envolvemoos a coluna que queremos esconder
                  //passamos a key state 
                  offstage: registerAdm,
                  child: const Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(label: Text('Nome')),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextField(
                        decoration: InputDecoration(label: Text('E-mail')),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextField(
                        decoration: InputDecoration(label: Text('Senha')),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                WeekdaysPanel(onDayPressed: (String day) {}),
                const SizedBox(
                  height: 24,
                ),
                HoursPanel(
                  startTime: 6,
                  endTime: 23,
                  onPressed: (int hour) {},
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () {},
                  child: const Text('CADASTRAR COLABORADOR'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
