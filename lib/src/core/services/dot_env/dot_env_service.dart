import 'dart:io';

class DotEnvService {
  final Map<String, String> _map = {};

  DotEnvService({Map<String, String>? mocks}) {
    if (mocks == null) {
      _init();
    } else {
      _map.addAll(mocks);
    }
  }

  // static DotEnvService instance = DotEnvService._();
  // DotEnvService._() {
  //   _init();
  // }

  void _init() {
    final file = File('.env');

    final envText = file.readAsStringSync();

    for (var line in envText.split('\n')) {
      final lineBreak = line.split('=');
      _map[lineBreak[0]] = lineBreak[1];
    }
  }

  // String? getValue(String key) {
  //   return _map[key];
  // }

  // ou [ Semana do backend #7 - Técnica DotEnv(.env) :: 7 minutos ]
  String? operator [](String key) {
    return _map[key];
  }
}
