abstract class BcryptService {
  String gererateHash(String text);
  bool checkHash(String text, String hash);
}
