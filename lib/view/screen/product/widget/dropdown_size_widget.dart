import 'package:flutter/material.dart';

class DropDownCustomSize extends StatefulWidget {


  @override
  State<DropDownCustomSize> createState() => _DropDownCustomSizeState();
}

class _DropDownCustomSizeState extends State<DropDownCustomSize> {
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String dropdownvalue = 'Item 1';
  Widget build(BuildContext context) {
    return  Row(
      children: [

        Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),

          margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
          width: MediaQuery.of(context).size.width*0.7,
          child: Row(
            children: [
              DropdownButton(
                hint:   Text(
                  "المقاس",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),


                // Initial Value


                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down,color: Colors.transparent,),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String newValue) {
                  setState(() {
                    dropdownvalue = newValue;
                  });
                },
              ),
            ],
          ),
        ),
         InkWell(
        onTap: (){},
        child: Row(
          children: [
            Icon(Icons.edit),
            Text('دليل المقاسات')
          ],
        ),
      )
      ],
    );
  }
}
