import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      //alteraçõces assim sao possiveis por conta da Stack
      children: [
        Container(
          //nossa stack maior que a imagem para que ela possa ser
          //posicionada com a impressao acima da imagem avatar  
          width: 102,
          height: 102,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(ImageConstants.avatar))),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              //Aumentando a borda para aumentar o tamanho total
              border: Border.all(color: ColorsConstants.brow, width: 4),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              BarbershopIcons.addEmployee,
              color: ColorsConstants.brow,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }
}
