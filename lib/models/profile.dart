import 'package:chat/models/models.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'profile.mapper.dart';

@MappableClass(caseStyle: caseStyle)
class Profile with ProfileMappable {
  final String id;
  final String username;
  final DateTime createdAt;

  Profile({required this.id, required this.username, required this.createdAt});
}
