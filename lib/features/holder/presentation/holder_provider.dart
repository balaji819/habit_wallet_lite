import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/core/utils/bank_holder_parser.dart';
import 'package:habit_wallet_lite/domain/entities/holder_entity.dart';

final holderListProvider = FutureProvider<List<HolderEntity>>((ref) async {
  return BankHolderParser.loadHolders(
    'assets/mock/bank_transactions.json',
  );
});
