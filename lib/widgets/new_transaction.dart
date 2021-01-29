import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function addTransactionHandle;

  NewTransaction(this.addTransactionHandle);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    //check value
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty ||
        enteredAmount <= 0||amountController.text.isEmpty
        ||_selectedDate==null) {
      return;
    }
    widget.addTransactionHandle(enteredTitle, enteredAmount,_selectedDate);
    //to close bottom sheet
    Navigator.of(context).pop();
  }

  void _showSelectedDatePicker(){
    showDatePicker(context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2020), lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate==null){
        return;
      }
      _selectedDate=pickedDate;
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'title'),
              autofocus: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: titleController,
            ),
            TextField(
                decoration: InputDecoration(labelText: 'amount'),
                keyboardType: TextInputType.number,
                controller: amountController,
                onSubmitted: (value) => submitData()),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate==null ?'No data chosen':
                     DateFormat.yMMMEd().format(_selectedDate)),
                  ),
                  FlatButton(
                    onPressed: _showSelectedDatePicker,
                    child: Text('Choose Date',
                        style: TextStyle(color: Colors.deepPurple)),
                  ),
                ],
              ),
            ),
            OutlineButton(
                onPressed: () => submitData(),
                child: Text(
                  'add transaction',
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
