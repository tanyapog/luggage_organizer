import 'package:firebase_auth/firebase_auth.dart' as firebase;

import '../../../global/domain/models/user/user.dart';
import '../../../utils/string_extension.dart';

extension FirebaseUserMapper on firebase.User {
  User toDomain() => User(
    id: uid,
    // LuggageOrganizer doesn't permit incorrect email while Firebase do, so ! is ok here
    name: displayName.isNotNullNorEmpty ? displayName! : email!.split('@').first,
    email: email!,
  );
}