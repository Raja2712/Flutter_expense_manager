import 'package:flutter/material.dart';
import './Widget/transaction_input.dart';
import 'Widget/transactionList.dart';
import 'Widget/chart.dart';
import 'Model/Transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily:'Quicksand',
          textTheme:ThemeData.light().textTheme.copyWith(
          title:TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight:FontWeight.bold
          ),
            button: TextStyle(color: Colors.white)

      )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Transaction> _userTransactionList = [  ];

  List<Transaction> get _recentTransactions
  {
    return _userTransactionList.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction({@required String title, @required double txAmount,@required DateTime selectedDate}) {
    var newTrans = Transaction(
        reason: title,
        amount: txAmount,
        date: selectedDate==null? DateTime.now():selectedDate,
        id: DateTime.now().toIso8601String());

    setState(() {
      _userTransactionList.add(newTrans);
    });
  }

  void _deleteTranasctions(@required String id)
  {
    setState(() {
      _userTransactionList.removeWhere((tx){
        return tx.id==id;
      });
    });
  }
  void _startNewActionTransc(BuildContext txt) {
    showModalBottomSheet(
        context: txt,
        builder: (BuildContext context) {

          return GestureDetector(
            onTap: () {},
            child:TransactionInput(addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );

        },);
  }


  /* */


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startNewActionTransc(context),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Chart(_recentTransactions),
              ),
              TransactionList(_userTransactionList,_deleteTranasctions),
            ],
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startNewActionTransc(context)
      ),
    );
  }
}
