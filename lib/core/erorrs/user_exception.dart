import 'package:anonymous_chat/core/erorrs/custom_exception.dart';

class UserException extends CustomException {
  UserException({
    super.title = 'User exception',
    super.text = 'Something happened',
  });
}

class UserExceptionDataUpdating extends UserException {
  UserExceptionDataUpdating()
      : super(
          title: 'Data updating exception',
          text:
              'Something happened while updating your data. Please make sure you have provided valid data!',
        );
}

class UserExceptionDataRetrieving extends UserException {
  UserExceptionDataRetrieving()
      : super(
          title: 'Data retrieving exception',
          text: 'Something happened while retrieving user data.',
        );
}

class UserExceptionInvalidCredentials extends UserException {
  UserExceptionInvalidCredentials()
      : super(
          title: 'Invalid credentials',
          text: 'You have provided invalid credentials!',
        );
}

class UserExceptionUnathorizedRequestToUserData extends UserException {
  UserExceptionUnathorizedRequestToUserData()
      : super(
          title: 'Unathorized',
          text: 'You do not have permission to this user\'s data!',
        );
}

class UserExceptionForbiddenRequestToDataUser extends UserException {
  UserExceptionForbiddenRequestToDataUser()
      : super(
          title: 'Forbidden',
          text: 'You do not have permission to this user\'s data!',
        );
}
