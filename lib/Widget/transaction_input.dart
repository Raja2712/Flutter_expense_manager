import 'package:flutter/material.dart';

class TransactionInput extends StatefulWidget {
  Function addTrans;

  TransactionInput(this.addTrans);

  @override
  _TransactionInputState createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  Function submitData() {
    String enteredTitle = titleController.text;
    double enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isNotEmpty  && enteredAmount >= 0)
    {

      widget.addTrans(
          title: enteredTitle,
          txAmount: enteredAmount);

      Navigator.of(context).pop();
    }


  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              autofocus: true,
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_)=>submitData(),
            ),
            TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.numberWithOptions(),
              onSubmitted: (_)=>submitData(),
            ),

            FlatButton(
                child: Text('Add Transactions'),
                textColor: Theme.of(context).accentColor,
                onPressed: submitData //(){print(amountController.text);}
                ),
          ],
        ),
      ),
    );
  }
}
