import 'package:flutter/material.dart';
import 'package:personal_expenses/utils/constriains.dart';

class ChartBar extends StatelessWidget {
  String lable;
  double spendingAmount;
  double spendingPctOfTotal;

  ChartBar(this.lable, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: [
          FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
          SizedBox(
            height: 4,
          ),
          Container(
            height:constraint.maxHeight*0.7,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration:
                    BoxDecoration(color: Theme
                        .of(context)
                        .primaryColor,
                      borderRadius: BorderRadius.circular(10),),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(lable,
            style: Theme
                .of(context)
                .textTheme
                .subtitle2,),
        ],
      );
    });
  }
}
