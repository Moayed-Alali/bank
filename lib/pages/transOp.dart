import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voice_ai_app/pages/Transaction%20data/transaction.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إضافة تحويل")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "اسم المستفيد"),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "المبلغ"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newTransaction = TransactionModel(
                  title: _titleController.text,
                  date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                  amount: double.parse(_amountController.text),
                  isIncome: false,
                );
                Navigator.pop(context, newTransaction);
              },
              child: Text("إضافة"),
            ),
          ],
        ),
      ),
    );
  }
}
