import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/custom_themes.dart';

class FiltersScreen extends StatefulWidget {
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  List<bool> _value = <bool>[];
  RangeValues _currentRangeValues = const RangeValues(0, 100);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: AppConstants.textScaleFactior),
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text("السعر", style: robotoBold),
                    RangeSlider(
                      max: 100,
                        divisions: 100,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        values: _currentRangeValues,
                        onChanged: (value) {
                        setState(() {
                          _currentRangeValues = value;

                        });
                        })
                  ],
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("التصنيف", style: robotoBold),
                Container(
                    height: 200,
                    margin: EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        _value.add(false);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("التصنيف$index",  style: robotoBold),
                            Checkbox(
                                value: _value[index],
                                onChanged: (value) {
                                  setState(() {
                                    _value[index] = value;
                                  });
                                })
                          ],
                        );
                      },
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
