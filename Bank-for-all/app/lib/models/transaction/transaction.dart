import 'package:bank_for_all/enums/transaction_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  final String amount, closingBalance, narration, id;
  final DateTime time;
  final TransactionType transactionType;

  Transaction({
    this.id,
    this.amount,
    this.closingBalance,
    this.narration,
    this.time,
    this.transactionType,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
