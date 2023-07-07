class Message {
  final String text;
  final int fromUser;
  final int toUser;
  final DateTime time;
  Message? repliedToMessage;

  Message(this.text, this.fromUser, this.toUser,
      {DateTime? time, this.repliedToMessage})
      : time = time ?? DateTime.now();
}
