import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> userHealthRecord(String displayName) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  //FirebaseAuth auth= FirebaseAuth.instance;
  var bloodpressure = 0;
  var sugarlevel = 0;
  var date = 0;
  users.add(
      {'bloodpressure': bloodpressure, 'sugarlevel': sugarlevel, 'date': date});
  return;
}
