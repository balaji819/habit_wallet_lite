import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:habit_wallet_lite/domain/entities/account_summary.dart';

class BankSummaryLoader {
  static Future<AccountSummary> loadFromAssets(String path) async {
    final raw = await rootBundle.loadString(path);
    final decoded = json.decode(raw) as Map<String, dynamic>;

    final bank = decoded.values.first.first;
    final summary = bank['decrypted_data']['Account']['Summary'];

    return AccountSummary(
      balance: double.parse(summary['currentBalance']),
      accountType: summary['type'],
      status: summary['status'],
      ifscCode: summary['ifscCode'],
      branch: summary['branch'],
      balanceDate:
      DateTime.parse(summary['balanceDateTime']),
    );
  }
}
