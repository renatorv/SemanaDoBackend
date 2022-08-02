
import 'package:backend/src/core/services/jwt/jwt_service.dart';

class JwtServiceImpl implements JwtService {
  @override
  String generateToken(Map claims, String audience) {
    throw UnimplementedError();
  }

  @override
  Map getPayload(String token) {
    throw UnimplementedError();
  }

  @override
  void verifyToken(String token, String audience) {
  }
  
}