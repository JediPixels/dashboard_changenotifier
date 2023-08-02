import 'dart:async';
import '../classes/coffee_change_notifier.dart';
import '../classes/mood_vertical_bar_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late CoffeeChangeNotifier coffeeChangeNotifier;
  late TotalCoffeeChangeNotifier totalCoffeeChangeNotifier;
  late Timer timerCoffee;
  late Timer timerTotalCoffee;
  int numberToPlotMax = 400;

  @override
  void initState() {
    super.initState();
    coffeeChangeNotifier = CoffeeChangeNotifier();
    totalCoffeeChangeNotifier = TotalCoffeeChangeNotifier();

    coffeeChangeNotifier.section = Section(
      espresso: 0,
      coffee: 0,
      latte: 0,
    );
    totalCoffeeChangeNotifier.totalCoffee = 0;

    timerCoffee = Timer.periodic(const Duration(seconds: 2), (timerCoffee) {
      if (timerCoffee.tick >= 30) {
        timerCoffee.cancel();
        debugPrint('--------- Coffee DONE ---------');
      } else {
        coffeeChangeNotifier.addNumberOfCoffee(espresso: 3, coffee: 5, latte: 4);
      }
    });
    timerTotalCoffee = Timer.periodic(const Duration(seconds: 3), (timerTotalCoffee) {
      if (timerTotalCoffee.tick >= 22) {
        timerTotalCoffee.cancel();
        debugPrint('--------- Total Coffee DONE ---------');
      } else {
        totalCoffeeChangeNotifier.totalNumberOfCoffee(
            espresso: coffeeChangeNotifier.section.espresso,
            coffee:  coffeeChangeNotifier.section.coffee,
            latte:  coffeeChangeNotifier.section.latte,
        );
      }
    });
  }

  @override
  void dispose() {
    coffeeChangeNotifier.dispose();
    totalCoffeeChangeNotifier.dispose();
    timerCoffee.cancel();
    timerTotalCoffee.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade50,
      appBar: AppBar(
        title: Text('Dashboard',
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
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(32.0),
            child: Container()
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreen, Colors.lightGreen.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                      animation: coffeeChangeNotifier,
                      builder: (BuildContext context, Widget? snapshot) {
                        debugPrint('Espresso, Coffee, Latte: '
                            '${coffeeChangeNotifier.section.espresso}, '
                            '${coffeeChangeNotifier.section.coffee}, '
                            '${coffeeChangeNotifier.section.latte}');
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MoodVerticalBarWidget(
                              icon: Icons.coffee_maker_outlined,
                              numberToPlot: coffeeChangeNotifier.section.espresso,
                              numberToPlotMax: numberToPlotMax,
                              title: 'Espresso',
                            ),
                            const Padding(padding: EdgeInsets.only(left: 16.0)),
                            MoodVerticalBarWidget(
                              icon: Icons.coffee,
                              numberToPlot: coffeeChangeNotifier.section.coffee,
                              numberToPlotMax: numberToPlotMax,
                              title: 'Coffee',
                            ),
                            const Padding(padding: EdgeInsets.only(left: 16.0)),
                            MoodVerticalBarWidget(
                              icon: Icons.local_drink_outlined,
                              numberToPlot: coffeeChangeNotifier.section.latte,
                              numberToPlotMax: numberToPlotMax,
                              title: 'Latte',
                            ),
                          ],
                        );
                      }
                  ),
                  const Padding(padding: EdgeInsets.only(left: 32.0)),
                  AnimatedBuilder(
                      animation: totalCoffeeChangeNotifier,
                      builder: (BuildContext context, Widget? snapshot) {
                        debugPrint('Total: ${totalCoffeeChangeNotifier.totalCoffee}');
                        return MoodVerticalBarWidget(
                          icon: Icons.local_cafe_outlined,
                          numberToPlot: totalCoffeeChangeNotifier.totalCoffee,
                          numberToPlotMax: numberToPlotMax,
                          title: 'Total',
                        );
                      }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}