import 'package:flutter/material.dart';

class BarbershopRegisterPage extends StatelessWidget {

  const BarbershopRegisterPage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Cadastrar Estabelecimento'),),
           body: Padding(
            padding:  const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 19,
                  ),
                  TextFormField(),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(),
                   const SizedBox(
                    height: 24,
                  ),
                   const SizedBox(
                    height: 94,
                    child: Placeholder(),
                  ),
                   const SizedBox(
                    height: 24,
                  ),
                   const SizedBox(
                    height: 178,
                    child: Placeholder(),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton( 
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56)
                  ),
                  onPressed: (){},
                  child: const Text('CADASTRAR ESTABELECIMENTO') ,
                  ),
                ]),
            ),
           ),
       );
  }
}