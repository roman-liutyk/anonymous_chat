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
    this.username,
    this.email,
  });

  final String? username;
  final String? email;
}
