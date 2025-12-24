class AccountSummary {
  final double balance;
  final DateTime balanceDate;
  final String accountType;
  final String status;
  final String ifscCode;
  final String branch;

  AccountSummary({
    required this.balance,
    required this.balanceDate,
    required this.accountType,
    required this.status,
    required this.ifscCode,
    required this.branch,
  });
}
