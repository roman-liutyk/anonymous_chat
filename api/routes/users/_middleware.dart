import 'package:api/middlewares/jwt_middleware.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) => JWTMiddleware(handler);
