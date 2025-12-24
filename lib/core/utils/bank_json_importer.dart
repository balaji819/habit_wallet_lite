import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:habit_wallet_lite/domain/entities/transaction_entity.dart';
import 'package:uuid/uuid.dart';

class BankJsonImporter {
  static const _uuid = Uuid();

  /// Load JSON from assets
  static Future<List<TransactionEntity>> importFromAssets(
      String assetPath,
      ) async {
    final raw = await rootBundle.loadString(assetPath);
    final decoded = json.decode(raw) as Map<String, dynamic>;

    final List<TransactionEntity> transactions = [];

    decoded.forEach((_, accounts) {
      for (final account in accounts) {
        final txns =
        account['decrypted_data']['Account']['Transactions']['Transaction']
        as List<dynamic>;

        for (final txn in txns) {
          final isDebit = txn['type'] == 'DEBIT';
          final amount = double.parse(txn['amount']);
          final narration = txn['narration'] ?? '';
          final mode = txn['mode'] ?? '';

          transactions.add(
            TransactionEntity(
              id: _uuid.v4(),
              amount: isDebit ? -amount : amount,
              category: _inferCategory(
                narration: narration,
                mode: mode,
                amount: amount,
              ),

              /// Actual transaction timestamp
              timestamp: DateTime.parse(txn['transactionTimestamp']),

              valueDate: txn['valueDate'] != null
                  ? DateTime.parse(txn['valueDate'])
                  : null,

              note: narration,
              isSynced: false,
              editedLocally: false,
              updatedAt: DateTime.now(),
            ),
          );
        }
      }
    });

    return transactions;
  }


  static String _inferCategory({
    required String narration,
    required String mode,
    required double amount,
  }) {
    final n = narration.toLowerCase();
    final m = mode.toLowerCase();

    if (n.contains('salary') ||
        n.contains('employee salary') ||
        (n.contains('neft') && amount >= 20000)) {
      return 'Salary';
    }

    if (n.contains('mutual') ||
        n.contains('ipo') ||
        n.contains('shares') ||
        n.contains('stock') ||
        n.contains('dividend')) {
      return 'Investment';
    }

    if (n.contains('rent')) return 'Rent';

    if (n.contains('electricity') ||
        n.contains('water') ||
        n.contains('gas') ||
        n.contains('broadband') ||
        n.contains('phone') ||
        n.contains('bill')) {
      return 'Bills';
    }


    if (n.contains('insurance') ||
        n.contains('policy') ||
        n.contains('policybazaar') ||
        n.contains('lic')) {
      return 'Insurance';
    }

    if (n.contains('petrol') ||
        n.contains('diesel') ||
        n.contains('fuel') ||
        n.contains('hp petroleum') ||
        n.contains('irctc') ||
        n.contains('uber') ||
        n.contains('ola')) {
      return 'Travel';
    }

    if (n.contains('amazon') ||
        n.contains('flipkart') ||
        n.contains('myntra') ||
        n.contains('shopping')) {
      return 'Shopping';
    }

    if (n.contains('bharatpe') ||
        n.contains('swiggy') ||
        n.contains('zomato') ||
        n.contains('restaurant') ||
        n.contains('upi')) {
      return 'Food';
    }

    if (m == 'atm' || n.contains('atm')) {
      return 'Cash';
    }

    if (n.contains('fee') ||
        n.contains('tuition') ||
        n.contains('college') ||
        n.contains('school')) {
      return 'Fees';
    }

    if (n.contains('charge') ||
        n.contains('chrg') ||
        n.contains('alert') ||
        n.contains('usage')) {
      return 'Charges';
    }

    return 'Other';
  }
}
