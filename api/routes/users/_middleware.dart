import 'package:api/middlewares/jwt_middleware.dart';
import 'package:dart_frog/dart_frog.dart';

/// Does not allow user to make requests without JWT token.
///
/// JWT token verification is handled inside [JWTMiddleware].
Handler middleware(Handler handler) => JWTMiddleware(handler);
