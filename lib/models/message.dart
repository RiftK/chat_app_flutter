class Message {
  final String text;
  final int fromUser;
  final int toUser;
  final DateTime time;

  Message(this.text, this.fromUser, this.toUser, {DateTime? time})
      : time = time ?? DateTime.now();
}
