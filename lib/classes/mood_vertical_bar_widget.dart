import 'package:flutter/material.dart';

class MoodVerticalBarWidget extends StatelessWidget {

  final IconData icon;
  final int numberToPlot;
  final int numberToPlotMax;
  final String title;

  const MoodVerticalBarWidget(
      {Key? key,
        required this.icon,
        required this.numberToPlot,
        required this.numberToPlotMax,
        required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizedBoxHeight = MediaQuery.of(context).size.height * 0.7;
    double barHeight = numberToPlot.toDouble();
    barHeight = (sizedBoxHeight * (barHeight / numberToPlotMax)) * 0.7;
    double barWidth = 72.0;

    return Container(
      constraints: const BoxConstraints(minHeight: 400.0),
      height: sizedBoxHeight,
      width: barWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          BuildIcon(icon: icon, height: 48.0, width: 48.0,),
          const Padding(padding: EdgeInsets.only(top: 8.0)),
          Container(
            width: barWidth,
            height: barHeight,
            color: Colors.lightGreen.shade400,
          ),
          const Padding(padding: EdgeInsets.only(bottom: 8.0),),
          Text('$numberToPlot',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(1, 1),
                    blurRadius: 3,
                  ),
                ]
            ),
          ),
          Text(title)
        ],
      ),
    );
  }
}

class BuildIcon extends StatelessWidget {
  final IconData icon;
  final double height;
  final double width;

  const BuildIcon({Key? key, required this.icon, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.lightGreen,
      elevation: 8.0,
      shape: const CircleBorder(side: BorderSide(color: Colors.lightGreen)),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.lightGreen.withOpacity(0.15),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.lightGreen,
          ),
        ),
        child: Center(
          child: Icon(icon),
        ),
      ),
    );
  }
}