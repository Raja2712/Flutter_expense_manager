import 'package:flutter/material.dart';
import '../Model/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactionList;
  Function deleteTrans;

  TransactionList(this.transactionList,this.deleteTrans);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      child: this.transactionList.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No data found",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                              '₹${transactionList[index].amount.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    title: Text(transactionList[index].reason,
                        style: Theme.of(context).textTheme.title),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactionList[index].date),
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {deleteTrans(transactionList[index].id);},
                    ),
                  ),
                );
                /*  return Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 2,
                                      style: BorderStyle.solid)),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '₹${transactionList[index].amount.toStringAsFixed(2)}', //.toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              )),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  transactionList[index].reason,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  DateFormat()
                                      .format(transactionList[index].date),
                                  style: TextStyle(color: Colors.grey),
                                ),
                                RaisedButton(child: Text("New Button"),
                                elevation: 10,onPressed: (){},)
                              ],
                            ),
                          )
                        ],
                      ),
                    );*/
              },
              itemCount: transactionList.length
              /* ,*/
              ),
    );
  }
}
