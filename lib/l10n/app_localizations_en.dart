// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Habit Wallet Lite';

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get pin => 'PIN';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get loginButton => 'Login';

  @override
  String get enterEmailPin => 'Please enter email and PIN';

  @override
  String get invalidCredentials => 'Invalid email or PIN';

  @override
  String get transactions => 'Transactions';

  @override
  String get addTransaction => 'Add Transaction';

  @override
  String get noTransactions => 'No transactions';

  @override
  String get errorLoadingTransactions => 'Error loading transactions';

  @override
  String get currentBalance => 'Current Balance';

  @override
  String get accountType => 'Account Type';

  @override
  String get status => 'Status';

  @override
  String get ifscCode => 'IFSC Code';

  @override
  String get branch => 'Branch';

  @override
  String get editedLocally => 'Edited locally';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get accountHolder => 'Account Holder';

  @override
  String get monthlySummary => 'Monthly Summary';

  @override
  String get toggleTheme => 'Toggle Theme';

  @override
  String get logout => 'Logout';

  @override
  String get income => 'Income';

  @override
  String get expense => 'Expense';

  @override
  String get incomeVsExpense => 'Income vs Expense';

  @override
  String get categoryBreakdown => 'Category Breakdown';

  @override
  String get selectMonth => 'Select month';

  @override
  String get amount => 'Amount';

  @override
  String get category => 'Category';

  @override
  String get note => 'Note';

  @override
  String get transactionDate => 'Transaction Date';

  @override
  String get change => 'Change';

  @override
  String get save => 'Save';

  @override
  String get enterValidAmount => 'Enter a valid amount';

  @override
  String get editTransaction => 'Edit Transaction';

  @override
  String get attachments => 'Attachments';

  @override
  String get addAttachment => 'Add attachment';

  @override
  String get attachmentStubNote => 'Supported (stub only)';

  @override
  String get attachmentNotImplemented =>
      'File picker not implemented in this version';

  @override
  String get noAttachments => 'No attachments adde';

  @override
  String get retry => 'Retry';
}
