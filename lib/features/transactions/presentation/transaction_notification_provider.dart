import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/core/notifications/notification_service.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/transaction_provider.dart';

final transactionNotificationProvider = Provider<void>((ref) {
  ref.listen(transactionListProvider, (previous, next) {
    next.when(
      loading: () {},
      error: (_, __) {},
      data: (transactions) {
        final now = DateTime.now();

        final hasTransactionToday = transactions.any((tx) =>
        tx.timestamp.year == now.year &&
            tx.timestamp.month == now.month &&
            tx.timestamp.day == now.day);

        if (hasTransactionToday) {
          //  User added transaction → cancel reminder
          NotificationService.cancelDailyReminder();
        } else {
          //  No transaction today → schedule 8 PM reminder
          NotificationService.scheduleDailyReminder();
        }
      },
    );
  });
});
