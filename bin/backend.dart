import 'package:backend/backend.dart';
import 'package:shelf/shelf_io.dart' as io;

void main() async {
  final handler = await startShelfModular();

  final server = await io.serve(handler, '0.0.0.0', 4471);

  print('Server on-line: ${server.address.address}:${server.port}');
}
