import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:habit_wallet_lite/features/summary/presentation/summary_provider.dart';
import 'package:habit_wallet_lite/l10n/app_localizations.dart';

class MonthlySummaryScreen extends ConsumerWidget {
  const MonthlySummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final incomeExpense = ref.watch(incomeExpenseProvider);
    final categories = ref.watch(categoryBreakdownProvider);
    final selectedMonth = ref.watch(selectedMonthProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final income = incomeExpense['income'] ?? 0;
    final expense = incomeExpense['expense'] ?? 0;

    final maxValue = (income + expense).abs();
    final double interval = maxValue == 0 ? 1.0 : maxValue / 4;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          '${selectedMonth.year}-${selectedMonth.month.toString().padLeft(2, '0')}',
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_rounded),
            tooltip: l10n.selectMonth,
            onPressed: () async {
              final now = DateTime.now();
              final safeInitialDate =
              selectedMonth.isAfter(now) ? now : selectedMonth;

              final picked = await showDatePicker(
                context: context,
                initialDate: safeInitialDate,
                firstDate: DateTime(2020),
                lastDate: now,
              );

              if (picked != null) {
                ref.read(selectedMonthProvider.notifier).state = picked;
              }
            },
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          /// 💰 SUMMARY CARDS
          Row(
            children: [
              _SummaryCard(
                title: l10n.income,
                value: income,
                color: Colors.green,
                icon: Icons.arrow_downward_rounded,
              ),
              const SizedBox(width: 12),
              _SummaryCard(
                title: l10n.expense,
                value: expense,
                color: Colors.red,
                icon: Icons.arrow_upward_rounded,
              ),
            ],
          ),

          const SizedBox(height: 32),

          //  INCOME VS EXPENSE
          _SectionTitle(l10n.incomeVsExpense),
          const SizedBox(height: 12),

          _ChartCard(
            child: SizedBox(
              height: 220,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: income,
                          color: Colors.green,
                          width: 22,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: expense,
                          color: Colors.red,
                          width: 22,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ],
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) => Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            value == 0 ? l10n.income : l10n.expense,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: interval,
                    getDrawingHorizontalLine: (_) => FlLine(
                      color:
                      isDark ? Colors.white12 : Colors.grey.shade200,
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ),

          const SizedBox(height: 36),

          /// 🥧 CATEGORY BREAKDOWN
          _SectionTitle(l10n.categoryBreakdown),
          const SizedBox(height: 12),

          _ChartCard(
            child: SizedBox(
              height: 260,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 44,
                  sectionsSpace: 3,
                  sections: categories.entries.map((e) {
                    return PieChartSectionData(
                      value: e.value,
                      title:
                      '${e.key}\n${e.value.toStringAsFixed(0)}',
                      radius: 70,
                      titleStyle: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/// ---------------- UI HELPERS ----------------

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final Widget child;
  const _ChartCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: child,
      ),
    );
  }
}

/// ---------------- SUMMARY CARD ----------------

class _SummaryCard extends StatelessWidget {
  final String title;
  final double value;
  final Color color;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(icon, color: color),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}