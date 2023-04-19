import 'package:cloud_firestore/cloud_firestore.dart';

class ScreenArguments {
  CollectionReference<Map<String, dynamic>> likesRef;

  ScreenArguments.toLikes({
    required this.likesRef,
  });
}
