import 'package:charts_painter/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ChartApp()));
}

class ChartApp extends StatefulWidget {
  ChartApp({Key? key}) : super(key: key);

  @override
  _ChartAppState createState() => _ChartAppState();
}

class _ChartAppState extends State<ChartApp> {
  int? _selectedIndex = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      color: Colors.grey.shade600,
      child: Chart(
        state: ChartState(
            ChartData(
              [
                [2, 4, 6, 3, 2, 5, 4, 3, 2]
                    .map((e) => BarValue<void>(e.toDouble()))
                    .toList(),
              ],
              valueAxisMaxOver: 2,
            ),
            itemOptions: BarItemOptions(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
            ), behaviour: ChartBehaviour(
          onItemClicked: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ), backgroundDecorations: [
          GridDecoration(),
        ], foregroundDecorations: [
          SelectedItemDecoration(_selectedIndex),
        ]),
      ),
    );
  }
}
