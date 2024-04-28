class UserEvent {
  const UserEvent();
}

class UserEventInitialize extends UserEvent {
  const UserEventInitialize();
}

class UserEventClearState extends UserEvent {
  const UserEventClearState();
}

class UserEventUpdateData extends UserEvent {
  UserEventUpdateData({
    required this.username,
    required this.email,
  });

  final String username;
  final String email;
}
