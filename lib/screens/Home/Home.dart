import 'package:BudgetUI/data/data.dart';
import 'package:BudgetUI/helpers/color_helper.dart';
import 'package:BudgetUI/models/category_model.dart';
import 'package:BudgetUI/models/expense_model.dart';
import 'package:BudgetUI/widgets/chart_bar.dart';
import 'package:flutter/material.dart';

import '../category_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _buildCategory({Category category, double totalAmountSpent}) {
    return GestureDetector(
      onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryScreen(category: category)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: const EdgeInsets.all(10.0),
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(category.name,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
                Text(
                    '\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600))
              ],
            ),
            SizedBox(height: 10.0),
            LayoutBuilder(
              builder: (context, constraints) {
                print("Height ${constraints.maxHeight}");
                print('Width ${constraints.maxWidth}');
                final double maxHeight = constraints.maxHeight;
                final double maxWidth = constraints.maxWidth;
                final double percent =
                    (category.maxAmount - totalAmountSpent) / category.maxAmount;
                double barWidth = percent * maxWidth;
                if (barWidth < 0) {
                  barWidth = 0;
                }

                return Stack(
                  children: [
                    Container(
                      height: 20.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    Container(
                      height: 20.0,
                      width: barWidth,
                      decoration: BoxDecoration(
                          color: getColor(context, percent),
                          borderRadius: BorderRadius.circular(15.0)),
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            forceElevated: true,
            floating: true,
            expandedHeight: 90,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Simple Budget',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            leading: Icon(
              Icons.settings,
              size: 30.0,
            ),
            actions: [Icon(Icons.add)],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 6.0)
                        ]),
                    child: BarChild(expenses: weeklySpending),
                  );
                } else {
                  final Category category = categories[index - 1];
                  double totalAmountSpent = 0;
                  category.expenses.forEach((Expense expense) {
                    totalAmountSpent += expense.cost;
                  });
                  return _buildCategory(
                      category: category, totalAmountSpent: totalAmountSpent);
                }
              },
              childCount: 1 + categories.length,
            ),
          )
        ],
      ),
    );
  }
}
