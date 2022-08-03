import 'package:backend/src/core/services/dot_env/dot_env_service.dart';
import 'package:backend/src/core/services/jwt/dart_json_web_token/jwt_service_impl.dart';
import 'package:test/test.dart';

void main() {
  test(
    'jwt create',
    () async {
      final dotEnvService = DotEnvService(mocks: {
        'JWT_KEY': 'dfgskcolwierjf-jcsohzkjaosdf458dsafrea',
      });

      final jwt = JwtServiceImpl(dotEnvService);

      // Duração de 30 segundos
      final expiresDate = DateTime.now().add(Duration(seconds: 30));
      final expiresIn =
          Duration(milliseconds: expiresDate.millisecondsSinceEpoch).inSeconds;

      final token = jwt.generateToken({
        'id': 1,
        'rule': 'user',
        'exp': expiresIn,
      }, 'accessToken');

      print(token);
    },
  );

  test(
    'jwt verify',
    () async {
      final dotEnvService = DotEnvService(mocks: {
        'JWT_KEY': 'dfgskcolwierjf-jcsohzkjaosdf458dsafrea',
      });

      final jwt = JwtServiceImpl(dotEnvService);

      jwt.verifyToken(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwicnVsZSI6InVzZXIiLCJleHAiOjE2NTk1MjY2MjUsImlhdCI6MTY1OTUyNjU5NSwiYXVkIjoiYWNjZXNzVG9rZW4ifQ.WRN8mV85-ioj5G-f3S5g-OzvriBFFAdPGBR9DzZ8dSM',
        'accessToken',
      );
    },
  );

  test(
    'jwt payload',
    () async {
      final dotEnvService = DotEnvService(mocks: {
        'JWT_KEY': 'dfgskcolwierjf-jcsohzkjaosdf458dsafrea',
      });

      final jwt = JwtServiceImpl(dotEnvService);

      final payload = jwt.getPayload(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwicnVsZSI6InVzZXIiLCJleHAiOjE2NTk1MjY2MjUsImlhdCI6MTY1OTUyNjU5NSwiYXVkIjoiYWNjZXNzVG9rZW4ifQ.WRN8mV85-ioj5G-f3S5g-OzvriBFFAdPGBR9DzZ8dSM',
      );

      print(payload);
    },
  );
}
