import 'package:chat/models/models.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'message.mapper.dart';

@MappableClass(caseStyle: caseStyle)
class Message with MessageMappable {
  final String id;
  final String profileId;
  final String content;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.profileId,
    required this.content,
    required this.createdAt,
  });
}
