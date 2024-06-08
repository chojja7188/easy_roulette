import 'dart:math';

import 'package:flutter/material.dart';
import 'package:roulette/roulette.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  static final _random = Random();
  late RouletteController _controller;
  final colors = <Color>[
    Colors.red.withAlpha(50),
    Colors.green.withAlpha(30),
    Colors.blue.withAlpha(70),
    Colors.yellow.withAlpha(90),
    Colors.amber.withAlpha(50),
    Colors.indigo.withAlpha(70),
  ];

  @override
  void initState() {
    super.initState();
    _controller = RouletteController(
        vsync: this,
        group: RouletteGroup.uniform(
          colors.length,
          colorBuilder: (index) => colors[index],
        ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(64),
                  child: Roulette(controller: _controller)
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // rollTo에 룰렛이 멈춤
            await _controller.rollTo(1, offset: _random.nextDouble());
          }
      ),
    );
  }
}
