class Memory {
  static const operations = const ['%', '/', 'X', '+', '-', '=']; //Array com as operações permitidas

  String _value = '0';
  final _buffer = [0.0, 0.0]; // Memória da calculadora Indice 0 guarda o ultimo calculo acumulado e indice 1 o digito recem digitado.
  String _operation = ''; // Operacao que esta sendo realizada
  int _bufferIndex = 0; //Controla o indice do Buffer utilizado (0 ou 1)
  bool _wipeValue = false; //Controlar a limpeza da tela quando utiliza comandos
  String _lastCommand = ''; // Ultimo comando acionado

  /*Aplicar o comando selecionado */
  void applyCommand(String command) {
    if (_isReplacingOpeation(command)) {
      _operation = command;
    }
    if (command == 'AC') { //Botão AC para limpar a tela e começar novo calculo
      allClear();
    } else if (operations.contains(command)) {//Realizar uma operação (+,-,*,/ ou MOD)
      _setOperation(command);
    } else {
      _addDigit(command); // Adiciona os digitos (0 a 10)
    }

    _lastCommand = command;
  }

  /*Substitui a ultima operacao quando, selecionar dois comandos */
  _isReplacingOpeation(String command) {
    return operations.contains(_lastCommand) &&
        operations.contains(command) &&
        _lastCommand != '=' &&
        command != '=';
  }

  /*Adiciona os digitos - Botões dos números  serem calculados */
  _addDigit(String digit) {
    final isDot = digit == ',';
    final wipeValue = (_value == '0' && !isDot) || _wipeValue;

    if (isDot && _value.contains(',') && !wipeValue) {
      //Caso for ponto e não estiver limpando os dados
      return;
    }
    final emptyValue = isDot ? '0' : '';
    final currentValue = wipeValue ? emptyValue : _value;

    _value = currentValue + digit;
    _wipeValue = false;

    _buffer[_bufferIndex] = double.tryParse(_value) ??
        0; // Adiciona  e caso nao consiga converter para double seta 0
  }

  /*Trata a operação que esta sendo realizada */
  _setOperation(String newOperation) {
    if (_bufferIndex == 0) {
      if (newOperation != '=') {
        _operation = newOperation;
        _bufferIndex = 1;
        _wipeValue = true; //LImpar o display
      }
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString();
      _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;
      if (newOperation == '=') {
        _operation = '';
        _bufferIndex = 0;
      } else {
        _operation = newOperation;
        _bufferIndex = 1;
      }
    }
    _wipeValue = true; //LImpar o display
    _buffer[_bufferIndex];
  }

  /*Ação do Botão AC */
  void allClear() {
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _operation = '';
    _bufferIndex = 0;
    _wipeValue = false;
  }

  String get value {
    return _value;
  }

  /*realiza a operação selecionada */
  double _calculate() {
    switch (_operation) {
      case '%':
        return _buffer[0] % _buffer[1];
      case '/':
        return _buffer[0] / _buffer[1];
      case 'X':
        return _buffer[0] * _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      default:
        return _buffer[0];
    }
  }
}
