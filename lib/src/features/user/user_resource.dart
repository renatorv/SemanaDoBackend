import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

class UserResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/user', _getAllUsers),
        Route.get('/user/:id', _getUserById),
        Route.post('/user', _createUser),
        Route.put('/user', _updateUser),
        Route.delete('/user/:id', _deleteUser),
      ];

  FutureOr<Response> _getAllUsers() {
    return Response.ok('[_getAllUsers] ok');
  }

  FutureOr<Response> _getUserById(ModularArguments arguments) {
    return Response.ok('[_getUserById] User: ${arguments.params['id']}');
  }

  FutureOr<Response> _createUser(ModularArguments arguments) {
    // Receber informações JSon
    return Response.ok('[_createUser] Create User: ${arguments.data}');
  }

  FutureOr<Response> _updateUser(ModularArguments arguments) {
    // Receber informações JSon
    return Response.ok('[_updateUser] Updated User: ${arguments.data}');
  }

  FutureOr<Response> _deleteUser(ModularArguments arguments) {
    return Response.ok('[_deleteUser] Deleted User: ${arguments.params['id']}');
  }
}
