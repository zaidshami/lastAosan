
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/location_provider.dart';
import '../../../../utill/dimensions.dart';

class LocationSearchDialog extends StatefulWidget {
  final GoogleMapController mapController;
  LocationSearchDialog({@required this.mapController});

  @override
  _LocationSearchDialogState createState() => _LocationSearchDialogState();
}

class _LocationSearchDialogState extends State<LocationSearchDialog> {
  final TextEditingController _controller = TextEditingController();
  List<Prediction> _predictions = [];

  Future<void> _getPredictions(String query) async {
    _predictions = await Provider.of<LocationProvider>(context, listen: false).searchLocation(context, query);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 80),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(width: 1170, child: Column(
          children: [
            TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress,
              onChanged: _getPredictions,
              decoration: InputDecoration(
                hintText: getTranslated('search_location', context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(style: BorderStyle.none, width: 0),
                ),
                hintStyle: Theme.of(context).textTheme.headline2.copyWith(
                  fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).disabledColor,
                ),
                filled: true, fillColor: Theme.of(context).cardColor,
              ),
              style: Theme.of(context).textTheme.headline2.copyWith(
                color: Theme.of(context).textTheme.bodyText1.color, fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _predictions.length,
                itemBuilder: (context, index) {
                  final prediction = _predictions[index];
                  return ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(
                      prediction.description,
                      style: Theme.of(context).textTheme.headline2.copyWith(
                        color: Theme.of(context).textTheme.bodyText1.color, fontSize: Dimensions.FONT_SIZE_LARGE,
                      ),
                    ),
                    onTap: () {
                      Provider.of<LocationProvider>(context, listen: false)
                          .setLocation(prediction.placeId, prediction.description, widget.mapController);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}

///the orginal
/*
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/location_provider.dart';
import '../../../../utill/dimensions.dart';

class LocationSearchDialog extends StatelessWidget {
  final GoogleMapController mapController;
  LocationSearchDialog({@required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Container(
      margin: EdgeInsets.only(top: 80),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(width: 1170, child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _controller,
            textInputAction: TextInputAction.search,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              hintText: getTranslated('search_location', context),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(style: BorderStyle.none, width: 0),
              ),
              hintStyle: Theme.of(context).textTheme.headline2.copyWith(
                fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).disabledColor,
              ),
              filled: true, fillColor: Theme.of(context).cardColor,
            ),
            style: Theme.of(context).textTheme.headline2.copyWith(
              color: Theme.of(context).textTheme.bodyText1.color, fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
          ),
          suggestionsCallback: (pattern) async {
            return await Provider.of<LocationProvider>(context, listen: false).searchLocation(context, pattern);
          },
          itemBuilder: (context, Prediction suggestion) {
            return Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Row(children: [
                Icon(Icons.location_on),
                Expanded(
                  child: Text(suggestion.description, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Theme.of(context).textTheme.bodyText1.color, fontSize: Dimensions.FONT_SIZE_LARGE,
                  )),
                ),
              ]),
            );
          },
          onSuggestionSelected: (Prediction suggestion) {
            Provider.of<LocationProvider>(context, listen: false).setLocation(suggestion.placeId, suggestion.description, mapController);
            Navigator.pop(context);
          },
        )),
      ),
    );
  }
}*/