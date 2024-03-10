import 'package:cloud_firestore/cloud_firestore.dart';

import '../../injection.dart';
import '../domain/errors/errors.dart';
import '../domain/models/user/i_auth_facade.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> get userDocument async {
    final user = getIt<IAuthFacade>().signedInUser;
    if (user != null) {
      return getIt<FirebaseFirestore>().collection('users').doc(user.id);
    } else {
      throw NotAuthenticatedError();
    }
  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get tripCollection => collection('trips');
  CollectionReference get itemGroupCollection => collection('itemGroups');
  CollectionReference get itemCollection => collection('items');
  CollectionReference get tripAspectCollection => collection('tripAspects');
  CollectionReference get tripFeatureCollection => collection('tripFeatures');
}
