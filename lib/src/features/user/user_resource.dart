import 'dart:async';
import 'dart:convert';

import 'package:backend/src/core/services/database/remote_database.dart';
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

  FutureOr<Response> _getAllUsers(Injector injector) async {
    //
    final database = injector.get<RemoteDatabase>();

    //
    final res =
        await database.query('SELECT id, name, email, role FROM "User";');

    //
    final listUsers = res.map((e) => e['User']).toList();

    return Response.ok(jsonEncode(listUsers));
  }

  FutureOr<Response> _getUserById(
      ModularArguments arguments, Injector injector) async {
    final id = arguments.params['id'];
    final db = injector.get<RemoteDatabase>();

    //
    final res = await db.query(
        'SELECT id, name, email, role FROM "User" WHERE id = @id;',
        variables: {
          'id': id,
        });

    //
    final userMap = res.map((e) => e['User']).first;

    return Response.ok(jsonEncode(userMap));
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
