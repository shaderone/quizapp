// ? This file contains all the references related to firebase and firestore.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore = FirebaseFirestore.instance;

//Firebase User Collection Reference
final userRFC = fireStore.collection("users");

// when we invoke this reference, it'll create or point to the collection mentioned
final questionPaperCRF = fireStore.collection("questionPapers");
// ? To create a new collection, we need a reference from the old collection, ie; the id of the old collection
//DocumentReference typed method is the method that we use to create a sub collection in the firestore database.
DocumentReference questionsCRF({required String paperId, required String questionId}) {
  //create a new collection based on the previous collection (ie; questionPaperCRF)
  return questionPaperCRF.doc(paperId).collection("questions").doc(questionId);
}

//Firebase Storage Reference
Reference get firebaseStorageRF => FirebaseStorage.instance.ref();
