import 'package:chatter_box/core/utils/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatter_box/core/utils/logger.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Add a document to a collection
  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    try {
      await _db.collection(collection).add(data);
      log.i('Document added to $collection: $data');
    } catch (e) {
      final msg = FirebaseExceptionHandler.handleException(e);
      log.e('Failed to add document: $msg');
      rethrow;
    }
  }

  ///Get a real-time stream of documents
  Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionStream(
    String collection,
  ) {
    try {
      return _db.collection(collection).orderBy('timestamp').snapshots();
    } catch (e) {
      final msg = FirebaseExceptionHandler.handleException(e);
      log.e('Failed to get collection stream: $msg');
      rethrow;
    }
  }

  /// Update a document by ID
  Future<void> updateDocument(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _db.collection(collection).doc(docId).update(data);
      log.i('Document $docId in $collection updated: $data');
    } catch (e) {
      final msg = FirebaseExceptionHandler.handleException(e);
      log.e('Failed to update document: $msg');
      rethrow;
    }
  }

  /// Delete a document by ID
  Future<void> deleteDocument(String collection, String docId) async {
    try {
      await _db.collection(collection).doc(docId).delete();
      log.i('Document $docId deleted from $collection');
    } catch (e) {
      final msg = FirebaseExceptionHandler.handleException(e);
      log.e('Failed to delete document: $msg');
      rethrow;
    }
  }
}
