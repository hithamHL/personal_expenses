import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/models/Transaction.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amberAccent,
          fontFamily: 'ChakraPetch',
          //to change font default for app text
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                fontFamily: 'ChakraPetch',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),

            subtitle2: TextStyle(
              fontFamily: 'ChakraPetch',
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),

          //to change font default for app bar
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      title: TextStyle(
                    fontFamily: 'ChakraPetch',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )))),
      home: MyHomePage(title: 'Personal Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _transactionList = [
    Transaction(
        id: 't1', title: 'text 1', amount: 15.0, dateTime: DateTime.now()),
    Transaction(
        id: 't2', title: 'text 2', amount: 200.50, dateTime: DateTime.parse("2021-01-25T11:00:00.000Z")),
    Transaction(
        id: 't3', title: 'text 3', amount: 150, dateTime: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount,DateTime dateSelected) {
    final newItem = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        dateTime: dateSelected);
    setState(() {
      print('new added');
      _transactionList.add(newItem);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _transactionList.removeWhere((element) {
        return element.id==id;
      });
    });

  }

  List<Transaction> get _recentTransaction {
    return _transactionList.where((element) {
      //to get recent or date get after specific time
      //معنا هذه الجملة هل هذا التاريخ هو بعد التاريخ الحالي ناقص منه 7 ايام
      return element.dateTime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _startNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(
              _addNewTransaction,
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add_circle_outline_outlined,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                _startNewTransaction(context);
              })
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Chart(_recentTransaction),
          ),
          TransactionList(_transactionList,_deleteTransaction),
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_circle_outline_outlined,
          size: 32,
        ),
        onPressed: () {
          _startNewTransaction(context);
        },
      ),
    );
  }
}
