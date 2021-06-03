import 'package:flutter/material.dart';
import 'button.dart';

class ButtonRow extends StatelessWidget {

  final List<Button> buttons;

  ButtonRow(this.buttons); // Método Construtor

  @override
  Widget build(BuildContext context) {
    return Expanded( // Ocupar os espaços em branco
      flex: 1, 
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.fold(<Widget>[], (list, b){ //Acrescentando elementos na lista de forma acumulada
          list.isEmpty ? list.add(b) : list.addAll([SizedBox(width: 1,),b]); // SizedBox - Espaço entre os botoes de 1px])
          return list;
        } ),
        
      ),
    );
  }
}