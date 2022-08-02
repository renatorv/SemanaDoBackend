import 'package:bcrypt/bcrypt.dart';

import 'bcrypt_service.dart';

class BcryptServiceImpl implements BcryptService {
  @override
  bool checkHash(String text, String hash) {
    return BCrypt.checkpw(text, hash);
  }

  @override
  String gererateHash(String text) {
    final String hashed = BCrypt.hashpw(text, BCrypt.gensalt());
    return hashed;
  }
}



// final String hashed = BCrypt.hashpw('password', BCrypt.gensalt());
// // $2a$10$r6huirn1laq6UXBVu6ga9.sHca6sr6tQl3Tiq9LB6/6LMpR37XEGu

// final bool checkPassword = BCrypt.checkpw('password', hashed);
// // true