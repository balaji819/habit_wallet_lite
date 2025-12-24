import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/core/theme/theme_provider.dart';
import 'package:habit_wallet_lite/features/auth/presentation/auth_controller.dart';
import 'package:habit_wallet_lite/features/holder/presentation/holder_list_screen.dart';
import 'package:habit_wallet_lite/features/summary/presentation/account_summary_provider.dart';
import 'package:habit_wallet_lite/features/summary/presentation/dynamic_balance_provider.dart';
import 'package:habit_wallet_lite/features/summary/presentation/monthly_summary_screen.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/add_edit_transaction_screen.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/transaction_notification_provider.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/transaction_provider.dart';
import 'package:habit_wallet_lite/core/locale/locale_controller.dart';
import 'package:habit_wallet_lite/l10n/app_localizations.dart';

class TransactionListScreen extends ConsumerStatefulWidget {
  const TransactionListScreen({super.key});

  @override
  ConsumerState<TransactionListScreen> createState() =>
      _TransactionListScreenState();
}

class _TransactionListScreenState
    extends ConsumerState<TransactionListScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(transactionImportProvider);
      ref.read(transactionNotificationProvider);
    });
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final txsAsync = ref.watch(transactionListProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 72,
        title: Text(
          l10n.transactions,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: 0.3,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF66BB6A), Color(0xFF2E7D32)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            tooltip: l10n.changeLanguage,
            icon: const Icon(Icons.language_rounded, color: Colors.white),
            onPressed: () {
              ref.read(localeProvider.notifier).toggleLocale();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      drawer: const _AppDrawer(),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        icon: const Icon(Icons.add),
        label: Text(l10n.addTransaction),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditTransactionScreen(),
            ),
          );
          ref.invalidate(transactionListProvider);
        },
      ),

      body: txsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) =>
            Center(child: Text(l10n.errorLoadingTransactions)),
        data: (list) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 88),
            children: [
              const _AccountSummaryCard(),
              const SizedBox(height: 12),

              if (list.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Center(child: Text(l10n.noTransactions)),
                )
              else
                ...list.map((tx) {
                  final isExpense = tx.amount < 0;

                  return Card(
                    elevation: 1,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                AddEditTransactionScreen(transaction: tx),
                          ),
                        );
                        ref.invalidate(transactionListProvider);
                      },
                      leading: CircleAvatar(
                        backgroundColor: isExpense
                            ? Colors.red.withValues(alpha: 0.15)
                            : Colors.green.withValues(alpha: 0.15),
                        child: Icon(
                          isExpense
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: isExpense ? Colors.red : Colors.green,
                        ),
                      ),
                      title: Text(
                        tx.category,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (tx.note != null && tx.note!.isNotEmpty)
                            Text(tx.note!),
                          Text(
                            tx.timestamp
                                .toLocal()
                                .toString()
                                .substring(0, 16),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          if (tx.editedLocally)
                            Text(
                              l10n.editedLocally,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.orange,
                              ),
                            ),
                        ],
                      ),
                      trailing: Text(
                        isExpense
                            ? '-${tx.amount.abs().toStringAsFixed(2)}'
                            : '+${tx.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isExpense ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                  );
                }),
            ],
          );
        },
      ),
    );
  }
}

/// =======================================================
/// ACCOUNT SUMMARY CARD
/// =======================================================
class _AccountSummaryCard extends ConsumerWidget {
  const _AccountSummaryCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final summaryAsync = ref.watch(accountSummaryProvider);
    final currentBalance = ref.watch(currentBalanceProvider);

    return summaryAsync.when(
      loading: () => const SizedBox(),
      error: (_, __) => const SizedBox(),
      data: (summary) {
        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF43A047), Color(0xFF1B5E20)],
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.currentBalance,
                  style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 6),
              Text(
                '₹ ${currentBalance.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Divider(color: Colors.white24, height: 24),
              _Row(label: l10n.accountType, value: summary.accountType),
              _Row(label: l10n.status, value: summary.status),
              _Row(label: l10n.ifscCode, value: summary.ifscCode),
              _Row(label: l10n.branch, value: summary.branch),
            ],
          ),
        );
      },
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;

  const _Row({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// DRAWER
/// =======================================================
class _AppDrawer extends ConsumerWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF66BB6A), Color(0xFF2E7D32)],
              ),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.account_balance_wallet_rounded,
                      color: Color(0xFF2E7D32), size: 30),
                ),
                SizedBox(width: 14),
                Text(
                  'Habit Wallet Lite',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _DrawerItem(
                  icon: Icons.person_outline_rounded,
                  title: l10n.accountHolder,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HolderListScreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Icons.pie_chart_outline_rounded,
                  title: l10n.monthlySummary,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MonthlySummaryScreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Icons.brightness_6_rounded,
                  title: l10n.toggleTheme,
                  onTap: () {
                    Navigator.pop(context);
                    final notifier =
                    ref.read(themeModeProvider.notifier);
                    notifier.state =
                    notifier.state == ThemeMode.dark
                        ? ThemeMode.light
                        : ThemeMode.dark;
                  },
                ),
                const Divider(height: 24),
                _DrawerItem(
                  icon: Icons.logout_rounded,
                  title: l10n.logout,
                  isDanger: true,
                  onTap: () async {
                    Navigator.pop(context);
                    await ref
                        .read(authControllerProvider.notifier)
                        .logout();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDanger;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDanger ? Colors.red : Colors.black87;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500, color: color),
      ),
      onTap: onTap,
    );
  }
}
