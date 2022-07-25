import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

void main() async {
  var pipeline = Pipeline().addMiddleware(log());

  final server = await io.serve( pipeline.addHandler(_handler),
    '0.0.0.0',
    4470,
  );

  print('Online: ${server.address.address}:${server.port}');
}

Middleware log() {
  return (handler) {
    return (request) async {
      // antes de executar
      print('Solicitado: ${request.url}');
      var response = await handler(request);
      print('[${response.statusCode}] - Response');

      // depois de executar
      return response;
    };
  };
}

FutureOr<Response> _handler(Request request) {
  print(request);
  return Response(200, body: 'Corpo......');
}
