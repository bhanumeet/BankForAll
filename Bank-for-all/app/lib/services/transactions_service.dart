import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/transaction/transaction.dart' as trans;
import '../utils/setup_locator.dart';
import 'shared_prefs.dart';

class TransactionService {
  final Firestore _db = Firestore.instance;
  final SharedPrefs user = locator<SharedPrefs>();
  CollectionReference ref;

  TransactionService() {
    init();
  }

  Future<void> init() async {
    await user.getUser();

    ref = _db
        .collection("users")
        .document(user.authID)
        .collection("transactions");
  }

  Stream<QuerySnapshot> getAllTransactions() {
    return ref.snapshots();
  }

  Stream<QuerySnapshot> getDeposit() {
    init();
    return ref.where("transactionType", isEqualTo: "deposit").snapshots();
  }

  Stream<QuerySnapshot> getWithdraw() {
    init();
    return ref.where("transactionType", isEqualTo: "withdraw").snapshots();
  }

  Future<DocumentReference> addTransaction(trans.Transaction tran) async {
    await init();
    return ref.add(tran.toJson());
  }
}
