import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/Transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transactionList,
    @required Function deleteTransaction,
  }) : _deleteTransaction = deleteTransaction, super(key: key);

  final Transaction transactionList;
  final Function _deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.deepPurple,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
                child:
                Text('\$${transactionList.amount}')),
          ),
        ),
        title: Text(
          transactionList.title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(
          DateFormat.yMMMEd()
              .format(transactionList.dateTime),
          style: TextStyle(fontSize: 12),
        ),
        selectedTileColor: Colors.indigoAccent,
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () {
            _deleteTransaction(transactionList.id);
          },
        ),
      ),
    );
  }
}