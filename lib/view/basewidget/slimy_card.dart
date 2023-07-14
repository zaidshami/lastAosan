

import 'package:flutter/material.dart';



class SlimyCard extends StatefulWidget {
  @override
  _SlimyCardState createState() => _SlimyCardState();
}

class _SlimyCardState extends State<SlimyCard> {
  @override
  Widget build(BuildContext context) {
    return   SlimyCard(
      // topCardHeight: 150,
      // topCardWidget: bottomCardWidget(),
      // bottomCardWidget: topCardWidget(),
    );
  }

  // This widget will be passed as Top Card's Widget.
  Widget topCardWidget() {
    return Text(
      'customize as you wish.11',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white.withOpacity(.85),
      ),
    );
  }

  // This widget will be passed as Bottom Card's Widget.
  Widget bottomCardWidget() {
    return Text(
      'customize as you wish.',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white.withOpacity(.85),
      ),
    );
  }
}