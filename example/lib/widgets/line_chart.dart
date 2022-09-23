import 'package:charts_painter/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef DataToValue<T> = double Function(T item);
typedef DataToAxis<T> = String Function(int item);

class LineChart<T> extends StatelessWidget {
  LineChart({
    required this.data,
    required this.dataToValue,
    this.height = 240.0,
    this.lineWidth = 2.0,
    this.itemColor,
    this.backgroundDecorations,
    this.foregroundDecorations,
    required this.chartItemOptions,
    this.chartBehaviour,
    this.smoothCurves = false,
    this.gradient,
    this.stack = false,
    Key? key,
  })  : _mappedValues = [
          data!.map((e) => BubbleValue<T>(dataToValue!(e))).toList()
              as List<ChartItem<T>>
        ],
        super(key: key);

  LineChart.multiple(
    this._mappedValues, {
    this.height = 240.0,
    this.lineWidth = 2.0,
    this.itemColor,
    this.backgroundDecorations,
    this.foregroundDecorations,
    required this.chartItemOptions,
    this.chartBehaviour,
    this.smoothCurves = false,
    this.gradient,
    this.stack = false,
    Key? key,
  })  : data = null,
        dataToValue = null,
        super(key: key);

  final List<T>? data;
  final DataToValue<T>? dataToValue;

  final double height;

  final bool smoothCurves;
  final Color? itemColor;
  final Gradient? gradient;
  final double lineWidth;
  final bool stack;

  final List<DecorationPainter>? backgroundDecorations;
  final List<DecorationPainter>? foregroundDecorations;
  final ChartBehaviour? chartBehaviour;
  final ItemOptions chartItemOptions;

  final List<List<ChartItem<T>>> _mappedValues;

  @override
  Widget build(BuildContext context) {
    final _foregroundDecorations =
        foregroundDecorations ?? <DecorationPainter>[];
    final _backgroundDecorations =
        backgroundDecorations ?? <DecorationPainter>[];

    return AnimatedChart<T>(
      height: height,
      duration: const Duration(milliseconds: 450),
      state: ChartState<T>(
        ChartData(
          _mappedValues,
          dataStrategy: stack ? StackDataStrategy() : DefaultDataStrategy(),
        ),
        itemOptions: chartItemOptions,
        foregroundDecorations: [
          SparkLineDecoration(
            id: 'chart_decoration',
            lineWidth: lineWidth,
            lineColor: itemColor ?? Theme.of(context).primaryColor,
            gradient: gradient,
            smoothPoints: smoothCurves,
          ),
          ..._foregroundDecorations,
        ],
        backgroundDecorations: [
          ..._backgroundDecorations,
        ],
      ),
    );
  }
}
