import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class UserInfoModel extends HiveObject {
  @HiveField(0)
  final String fname;

  @HiveField(1)
  final String lname;

  @HiveField(2)
  final String photoUrl;

  @HiveField(3)
  final String tnumber;

  @HiveField(4)
  final String ccode;

  UserInfoModel({
    this.fname,
    this.lname,
    this.photoUrl,
    this.tnumber,
    this.ccode,
  });
}
