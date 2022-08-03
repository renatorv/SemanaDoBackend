import 'dart:async';
import 'dart:convert';

import 'package:backend/src/core/services/bcrypt/bcrypt_service.dart';
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

  // GET ALL USERS
  FutureOr<Response> _getAllUsers(Injector injector) async {
    //
    //usar a interface RemoteDatabase e não sua implementação PostgresDatabase
    final database = injector.get<RemoteDatabase>();

    //
    final res =
        await database.query('SELECT id, name, email, role FROM "User";');

    //
    final listUsers = res.map((e) => e['User']).toList();

    return Response.ok(jsonEncode(listUsers));
  }

  // GET USER BY ID
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

  // CREATE
  FutureOr<Response> _createUser(
      ModularArguments arguments, Injector injector) async {
    // Recuperando BCrypt
    final bcrypt = injector.get<BcryptService>();
    //
    final userParams = (arguments.data as Map).cast<String, dynamic>();

    userParams['password'] = bcrypt.gererateHash(userParams['password']);

    //
    // remover o campo id caso ele tenha vindo
    // userParams.remove('id');

    final db = injector.get<RemoteDatabase>();

    //
    final res = await db.query(
        'INSERT INTO "User" (name, email, password) VALUES (@name, @email, @password) RETURNING id, name, email, role;',
        variables: userParams);

    //
    final userMap = res.map((e) => e['User']).first;

    return Response.ok(jsonEncode(userMap));
  }

  // UPDATE
  FutureOr<Response> _updateUser(
      ModularArguments arguments, Injector injector) async {
    //
    final userParams = (arguments.data as Map).cast<String, dynamic>();
    //

    final db = injector.get<RemoteDatabase>();

    final columns = userParams.keys
        .where((key) => key != 'id' || key != 'password')
        .map((key) => '$key=@$key')
        .toList();

    final query =
        'UPDATE "User" SET ${columns.join(',')} WHERE id=@id RETURNING id, name, email, role;';

    //
    final res = await db.query(
      query,
      variables: userParams,
    );

    //
    final userMap = res.map((e) => e['User']).first;

    return Response.ok(jsonEncode(userMap));
  }

  // DELETE
  FutureOr<Response> _deleteUser(
      ModularArguments arguments, Injector injector) async {
    final id = arguments.params['id'];
    final db = injector.get<RemoteDatabase>();

    //
    await db.query('DELETE FROM "User" WHERE id = @id;', variables: {
      'id': id,
    });

    // Testar res de alguma forma para confirmar se realmente foi deletado?

    return Response.ok(jsonEncode({'message': 'deleted $id'}));
  }
}
