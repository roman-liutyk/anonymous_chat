
/// Custom exception class that represents specified request exception code.
class CustomException implements Exception {
  const CustomException({required this.code});

  final int code;
}
