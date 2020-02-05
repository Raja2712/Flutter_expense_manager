import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionInput extends StatefulWidget {
  Function addTrans;

  TransactionInput(this.addTrans);

  @override
  _TransactionInputState createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _pickedDate;

  void submitData() {
    if(amountController.text.isEmpty)
      {
        return;
      }
    String enteredTitle = titleController.text;
    double enteredAmount = double.parse(amountController.text);
    DateTime _selectedDate = _pickedDate;

    if (enteredTitle.isNotEmpty && enteredAmount >= 0 && _selectedDate!=null) {
      widget.addTrans(title: enteredTitle, txAmount: enteredAmount,selectedDate:_selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _openDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
          if(pickedDate== null)
            {
              return;
            }
        setState(() {
          _pickedDate=pickedDate;
        });
    });
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
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(),
              onSubmitted: (_) => submitData(),
            ),
            //For Date
            Container(
              child: Row(
                children: <Widget>[
                  Text(_pickedDate==null? "No Dates Chosen!" :DateFormat.yMMMd().format(_pickedDate)),
                  Expanded(
                    child: FlatButton(
                      child: Text("Choose a date"),
                      onPressed: _openDatePicker,
                    ),
                  ),
                ],
              ),
            ),

            RaisedButton(
                child: Text('Add Transactions'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).buttonColor,
                onPressed: submitData //(){print(amountController.text);}
                ),
          ],
        ),
      ),
    );
  }
}
