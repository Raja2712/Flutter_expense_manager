import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/Widget/chart_bar.dart';
import 'package:intl/intl.dart';
import '../Model/Transaction.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get getGroupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }
      print(" " +
          DateFormat.E().format(weekDay) +
          "   " +
          totalAmount.toString());

      return {'day': DateFormat.E().format(weekDay), 'amount': totalAmount};
    });
  }

  double get totalSpending {
    return getGroupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(getGroupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: getGroupedTransactionValues.map((data) {
                  return Flexible(
                    fit: FlexFit.tight,

                    child: ChartBar(
                        data['day'],
                        data['amount'],
                        totalSpending == 0.0
                            ? 0.0
                            : (data['amount'] as double) / totalSpending),
                  );
                }).toList(),
              ),
            )
            /*Text('${data['day']}: ${data['amount']}'*/
          ],
          //$ symbol
          //Chart
          //Days
        ),
      ),
    );
  }
}
