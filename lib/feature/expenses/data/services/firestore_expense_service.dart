
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreExpenseService {
  final FirebaseFirestore _firestore;

  FirestoreExpenseService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> watchExpenses(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("expenses")
        .orderBy("date", descending: true)
        .snapshots();
  }

  Future<void> addExpense(String uid, Map<String, dynamic> data) async {
    final doc = _firestore
        .collection("users")
        .doc(uid)
        .collection("expenses")
        .doc();

    await doc.set(data);
  }

  Future<void> updateExpense(
      String uid, String expenseId, Map<String, dynamic> data) async {
    await _firestore
        .collection("users")
        .doc(uid)
        .collection("expenses")
        .doc(expenseId)
        .update(data);
  }

  Future<void> deleteExpense(String uid, String expenseId) async {
    await _firestore
        .collection("users")
        .doc(uid)
        .collection("expenses")
        .doc(expenseId)
        .delete();
  }
}