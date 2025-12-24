import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/domain/entities/transaction_entity.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/transaction_provider.dart';
import 'package:habit_wallet_lite/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';

class AddEditTransactionScreen extends ConsumerStatefulWidget {
  final TransactionEntity? transaction;

  const AddEditTransactionScreen({super.key, this.transaction});

  @override
  ConsumerState<AddEditTransactionScreen> createState() =>
      _AddEditTransactionScreenState();
}

class _AddEditTransactionScreenState
    extends ConsumerState<AddEditTransactionScreen> {
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();

  DateTime _date = DateTime.now();
  String _category = 'Other';

  /// 🔹 ATTACHMENTS (UI STUB ONLY)
  final List<PlatformFile> _attachments = [];

  final _categories = const [
    'Food',
    'Bills',
    'Travel',
    'Investment',
    'Insurance',
    'Cash',
    'Salary',
    'Other',
  ];

  final _incomeCategories = const ['Salary'];

  @override
  void initState() {
    super.initState();

    final tx = widget.transaction;
    if (tx != null) {
      _amountCtrl.text = tx.amount.abs().toString();
      _noteCtrl.text = tx.note ?? '';
      _category = tx.category;
      _date = tx.timestamp;
    }

    _noteCtrl.addListener(_autoInferCategory);
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.removeListener(_autoInferCategory);
    _noteCtrl.dispose();
    super.dispose();
  }

  void _autoInferCategory() {
    final note = _noteCtrl.text.toLowerCase();
    String inferred = _category;

    if (note.contains('salary')) {
      inferred = 'Salary';
    } else if (note.contains('rent') || note.contains('electricity')) {
      inferred = 'Bills';
    } else if (note.contains('mutual')) {
      inferred = 'Investment';
    } else if (note.contains('petrol') || note.contains('fuel')) {
      inferred = 'Travel';
    } else if (note.contains('atm')) {
      inferred = 'Cash';
    } else if (note.contains('insurance') || note.contains('policy')) {
      inferred = 'Insurance';
    }

    if (inferred != _category) {
      setState(() => _category = inferred);
    }
  }

  /// 📎 PICK ATTACHMENTS (LOCAL STUB)
  Future<void> _pickAttachments() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _attachments.addAll(result.files);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final repo = ref.read(transactionRepositoryProvider);
    final isEdit = widget.transaction != null;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          isEdit ? l10n.editTransaction : l10n.addTransaction,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF66BB6A), Color(0xFF2E7D32)],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        icon: const Icon(Icons.check),
        label: Text(l10n.save),
        onPressed: () async {
          final enteredAmount = double.tryParse(_amountCtrl.text.trim());
          if (enteredAmount == null || enteredAmount <= 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.enterValidAmount)),
            );
            return;
          }

          final isIncome = _incomeCategories.contains(_category);
          final finalAmount = isIncome ? enteredAmount : -enteredAmount;

          final tx = TransactionEntity(
            id: widget.transaction?.id ?? const Uuid().v4(),
            amount: finalAmount,
            category: _category,
            note: _noteCtrl.text.trim(),
            timestamp: _date,
            isSynced: false,
            editedLocally: isEdit,
            updatedAt: DateTime.now(),
          );

          if (isEdit) {
            await repo.update(tx);
          } else {
            await repo.add(tx);
          }

          if (context.mounted) Navigator.pop(context);
        },
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        child: Column(
          children: [
            _SectionTitle(l10n.amount),
            _AmountCard(controller: _amountCtrl),

            const SizedBox(height: 20),

            _SectionTitle(l10n.category),
            _CategoryCard(
              category: _category,
              categories: _categories,
              onChanged: (v) => setState(() => _category = v),
            ),

            const SizedBox(height: 20),

            _SectionTitle(l10n.note),
            _NoteCard(controller: _noteCtrl),

            const SizedBox(height: 20),

            /// 📎 ATTACHMENTS UI
            _SectionTitle(l10n.attachments),
            _AttachmentCard(
              attachments: _attachments,
              onAdd: _pickAttachments,
              onRemove: (file) {
                setState(() => _attachments.remove(file));
              },
            ),

            const SizedBox(height: 20),

            _SectionTitle(l10n.transactionDate),
            _DateCard(
              date: _date,
              onChanged: (d) => setState(() => _date = d),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------- UI HELPERS ----------------

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class _AmountCard extends StatelessWidget {
  final TextEditingController controller;
  const _AmountCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.currency_rupee),
            hintText: '0.00',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String category;
  final List<String> categories;
  final ValueChanged<String> onChanged;

  const _CategoryCard({
    required this.category,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButtonFormField<String>(
          initialValue: category,
          items: categories
              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
              .toList(),
          onChanged: (v) => onChanged(v!),
          decoration: const InputDecoration(border: InputBorder.none),
        ),
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final TextEditingController controller;
  const _NoteCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: controller,
          maxLines: 2,
          decoration: const InputDecoration(
            hintText: 'Optional note',
            prefixIcon: Icon(Icons.notes),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class _AttachmentCard extends StatelessWidget {
  final List<PlatformFile> attachments;
  final VoidCallback onAdd;
  final ValueChanged<PlatformFile> onRemove;

  const _AttachmentCard({
    required this.attachments,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.attach_file),
              label: Text(l10n.addAttachment),
            ),
            const SizedBox(height: 10),
            if (attachments.isEmpty)
              Text(
                l10n.noAttachments,
                style: const TextStyle(color: Colors.grey),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: attachments.map((file) {
                  return Chip(
                    label: Text(file.name, overflow: TextOverflow.ellipsis),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () => onRemove(file),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  const _DateCard({required this.date, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: const Icon(Icons.calendar_today),
        title: const Text('Transaction Date'),
        subtitle: Text(date.toLocal().toString().split(' ')[0]),
        trailing: TextButton(
          child: const Text('Change'),
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (picked != null) onChanged(picked);
          },
        ),
      ),
    );
  }
}
