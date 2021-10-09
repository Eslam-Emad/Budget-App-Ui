import 'package:flutter/material.dart';

class BarChild extends StatelessWidget {
  final List<double> expenses;
  BarChild({this.expenses});

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    expenses.forEach((element) {if(element > mostExpensive ){mostExpensive = element;}});
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text('Weekly Spending', style: TextStyle(fontSize: 18.0,fontWeight:FontWeight.bold,letterSpacing: 1.2)),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:[
              IconButton(icon: Icon(Icons.arrow_back,color:Colors.black),onPressed:(){}),
              Text('Nov 10, 2020 - Nov 16 2021',style:TextStyle(fontSize:16,fontWeight:FontWeight.w600)),
              IconButton(icon: Icon(Icons.arrow_forward,color: Colors.black),onPressed:(){})],
          ),
          SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Bar(label:'Su',amountSpent:expenses[0], mostExpensive: mostExpensive),
            Bar(label:'Mo',amountSpent:expenses[1], mostExpensive: mostExpensive),
            Bar(label:'Tu',amountSpent:expenses[2], mostExpensive: mostExpensive),
            Bar(label:'We',amountSpent:expenses[3], mostExpensive: mostExpensive),
            Bar(label:'Th',amountSpent:expenses[4], mostExpensive: mostExpensive),
            Bar(label:'Fr',amountSpent:expenses[5], mostExpensive: mostExpensive),
            Bar(label:'Sa',amountSpent:expenses[6], mostExpensive: mostExpensive),
          ],
        )

        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;
  final double _maxBarHeight = 150.0 ;
  Bar({this.label, this.amountSpent, this.mostExpensive});

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;
    return Column(
      children: [
        Text("\$${amountSpent.toStringAsFixed(2)}" , style: TextStyle(fontWeight: FontWeight.w600),),
        SizedBox(height: 6.0),
        Container(
          height: barHeight,
          width: 18.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        SizedBox(height: 8.0),
        Text(label , style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
