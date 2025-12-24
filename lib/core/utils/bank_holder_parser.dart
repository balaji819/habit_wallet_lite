import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:habit_wallet_lite/domain/entities/holder_entity.dart';

class BankHolderParser {
  static Future<List<HolderEntity>> loadHolders(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    final decoded = json.decode(raw) as Map<String, dynamic>;

    final List<HolderEntity> holders = [];

    decoded.forEach((_, accounts) {
      for (final account in accounts) {
        final holderJson =
        account['decrypted_data']['Account']['Profile']['Holders']['Holder'];

        holders.add(
          HolderEntity(
            name: holderJson['name'],
            dob: DateTime.parse(holderJson['dob']),
            mobile: holderJson['mobile'],
            nominee: holderJson['nominee'],
            landline: holderJson['landline'] ?? '',
            address: holderJson['address'],
            email: holderJson['email'],
            pan: holderJson['pan'],
            ckycCompliance: holderJson['ckycCompliance'] == 'true',
          ),
        );
      }
    });

    return holders;
  }
}
