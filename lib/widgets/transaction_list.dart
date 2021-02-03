import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_expenses/models/Transaction.dart';
import 'package:personal_expenses/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  Function _deleteTransaction;

  TransactionList(this.transactionList, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(

        //list builder take context builder
        child: transactionList.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset('assets/images/ic_zz.png',
                  //   fit: BoxFit.cover,),
                  Container(
                    child: Lottie.network(
                        'https://assets5.lottiefiles.com/packages/lf20_EMTsq1.json',
                        width: 250,
                        height: 250,
                        fit: BoxFit.fill),
                  ),

                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'No transaction added yet!!',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return TransactionItem(transactionList: transactionList[index], deleteTransaction: _deleteTransaction);
                },
                itemCount: transactionList.length,
              ));
  }
}


