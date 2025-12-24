import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/features/holder/presentation/holder_provider.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/transaction_provider.dart';
import 'package:habit_wallet_lite/l10n/app_localizations.dart';

class HolderListScreen extends ConsumerWidget {
  const HolderListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final holderAsync = ref.watch(holderListProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          l10n.accountHolder,
          style: const TextStyle(fontWeight: FontWeight.w600),
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
      ),

      body: holderAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 8),
              Text(
                l10n.errorLoadingTransactions,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: Text(l10n.retry),
                onPressed: () {
                  ref.invalidate(transactionListProvider);
                },
              ),
            ],
          ),
        ),
        data: (holders) {
          if (holders.isEmpty) {
            return Center(child: Text(l10n.noTransactions));
          }

          final holder = holders.first; // usually single holder

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              /// 🌿 PROFILE CARD
              _ProfileHeader(name: holder.name),

              const SizedBox(height: 24),

              /// 📄 DETAILS CARD
              _DetailCard(
                children: [
                  _InfoTile(label: l10n.accountHolder, value: holder.name),
                  _InfoTile(
                    label: 'DOB',
                    value: holder.dob.toLocal().toString().split(' ')[0],
                  ),
                  _InfoTile(label: 'Mobile', value: holder.mobile),
                  _InfoTile(label: 'Email', value: holder.email),
                  _InfoTile(label: 'PAN', value: holder.pan),
                  _InfoTile(label: 'Nominee', value: holder.nominee),
                  _InfoTile(label: 'Address', value: holder.address),
                  _InfoTile(
                    label: 'CKYC',
                    value: holder.ckycCompliance
                        ? 'Compliant'
                        : 'Not Compliant',
                    valueColor: holder.ckycCompliance
                        ? Colors.green
                        : Colors.red,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

/// ---------------- UI COMPONENTS ----------------

class _ProfileHeader extends StatelessWidget {
  final String name;
  const _ProfileHeader({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF66BB6A), Color(0xFF2E7D32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 32,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final List<Widget> children;
  const _DetailCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: children),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoTile({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
