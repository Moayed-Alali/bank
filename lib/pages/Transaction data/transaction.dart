class TransactionModel {
  final String title;
  final String date;
  final double amount;
  final bool isIncome;

  TransactionModel({
    required this.title,
    required this.date,
    required this.amount,
    required this.isIncome,
  });
}

final List<TransactionModel> transactions = [
  TransactionModel(
    title: "دفع فاتورة الكهرباء",
    date: "2025-07-21",
    amount: 250.75,
    isIncome: false,
  ),
  TransactionModel(
    title: "تحويل من أحمد",
    date: "2025-07-20",
    amount: 500.00,
    isIncome: true,
  ),
  TransactionModel(
    title: "دفع فاتورة الإنترنت",
    date: "2025-07-19",
    amount: 120.00,
    isIncome: false,
  ),
  TransactionModel(
    title: "راتب",
    date: "2025-07-18",
    amount: 3500.00,
    isIncome: true,
  ),
  TransactionModel(
    title: "تحويل إلى خالد",
    date: "2025-07-17",
    amount: 200.00,
    isIncome: false,
  ),
];
