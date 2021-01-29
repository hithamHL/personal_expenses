import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/Transaction.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      var totalSum = 0.0;
      //to get day use this methods
      var dayWeek = DateTime.now().subtract(Duration(days: index));
      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].dateTime.day == dayWeek.day &&
            recentTransaction[i].dateTime.month == dayWeek.month &&
            recentTransaction[i].dateTime.year == dayWeek.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      print(': $totalSum');

      return {'day': DateFormat.E().format(dayWeek), 'amount': totalSum};
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValue.fold(0.0, (sum, item) {
      print(('chart amount: ${item['amount'] as double})/${sum + item['amount']}'));
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValue);
    groupedTransactionValue.map((e) {
      print('chart amount: ${e['amount']}');

    });

    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  maxSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / maxSpending)
              ,
            );
          }).toList(),
        ),
      ),
    );
  }
}
