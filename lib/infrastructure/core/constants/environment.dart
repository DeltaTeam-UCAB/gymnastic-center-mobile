import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieDbKey = dotenv.env['API_URL'] ?? 'No hay api key';
}