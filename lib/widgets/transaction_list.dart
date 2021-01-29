import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_expenses/models/Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  Function _deleteTransaction;

  TransactionList(this.transactionList,this._deleteTransaction);


  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        //list builder take context builder
        child: transactionList.isEmpty?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image.asset('assets/images/ic_zz.png',
                //   fit: BoxFit.cover,),
                Container(child:
                Lottie.network('https://assets5.lottiefiles.com/packages/lf20_EMTsq1.json',
                width: 250,
                height: 250,
                fit: BoxFit.fill),),

                SizedBox(height: 8,),
                Text('No transaction added yet!!',
                  style: Theme.of(context).textTheme.bodyText1,),
              ],
            ):

        ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              elevation: 8,
              margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
              child: ListTile(
                leading: CircleAvatar(radius: 30 ,
                backgroundColor: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(child: Text('\$${transactionList[index].amount}')),
                ),),
                title: Text(transactionList[index].title,
                style: Theme.of(context).textTheme.bodyText1,) ,
                subtitle: Text(DateFormat.yMMMEd().format(transactionList[index].dateTime),
                  style: TextStyle(fontSize: 12),),
                selectedTileColor: Colors.indigoAccent,
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: (){
                    _deleteTransaction(transactionList[index].id);
                  },

                ),

              ),
            );
          },
          itemCount: transactionList.length,
        ));
  }
}
