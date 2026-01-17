import 'package:flutter/material.dart';
import 'package:service_provider/controller/db/transaction_services.dart';
import 'package:service_provider/model/transaction_model.dart';
import 'package:service_provider/view/screen/transctionHistory/transaction_card.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionService = TransactionServices();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transaction History",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,

      body: StreamBuilder<List<TransactionModel>>(
        stream: transactionService.getTransactions(),
        builder: (context, snapshot) {
          // 🔹 Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // 🔹 Error
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }

          final transactions = snapshot.data ?? [];

          // 🔹 Empty
          if (transactions.isEmpty) {
            return const Center(
              child: Text(
                "No transactions found",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          // 🔹 Success
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: transactions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return TransactionCard(
                transaction: transactions[index],
              );
            },
          );
        },
      ),
    );
  }
}
