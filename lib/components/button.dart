import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const DARK = Color.fromRGBO(82, 82, 82, 1);
  static const DEFAULT = Color.fromRGBO(112, 112, 112, 1);
  static const OPERATION = Color.fromRGBO(250, 158, 13, 1);

  final String text;
  final bool large;
  final Color color; 
  final void Function(String) cb;

  Button({
    required this.text,
    this.large = false, 
    this.color = DEFAULT, 
    required this.cb,
  });

  //Construtor Nomeado
  Button.large({
    required this.text,
    this.large = true, 
    this.color = DEFAULT, 
    required this.cb,
  });

  Button.operation({
    required this.text,
    this.large = false, 
    this.color = OPERATION, 
    required this.cb,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: large ? 2 : 1, // Se for large = true 2 senão 1 - Botao large ocupa 2 colunas
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: this.color // Cor de fundo
          
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.normal,

          ),
        ),
        onPressed: () => cb(text),
      ),
    );

  }
}