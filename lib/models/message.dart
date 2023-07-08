import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 1, adapterName: 'MessageAdapter')
class Message {
  Message(this.text, this.fromUser, this.toUser,
      {DateTime? time, this.repliedToMessage})
      : time = time ?? DateTime.now();

  @HiveField(0)
  final String text;

  @HiveField(1)
  final int fromUser;

  @HiveField(2)
  final int toUser;

  @HiveField(3)
  final DateTime time;

  @HiveField(4)
  Message? repliedToMessage;
}
