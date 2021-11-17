import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/utils.dart';

class MainWeather extends StatelessWidget {
  final wData;

  MainWeather({this.wData});

  final TextStyle _style1 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
  final TextStyle _style2 = TextStyle(
    fontWeight: FontWeight.w300,
    color: Colors.white,
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 18, 25, 5),
      height: MediaQuery.of(context).size.height / 3.4,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined),
              Text('${wData.weather.cityName}', style: _style1),
            ],
          ),
          SizedBox(height: 5),*/

          SizedBox(height: 45),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*Padding(
                padding: const EdgeInsets.only(bottom: 25, right: 25),
                child: MapString.mapStringToIcon(
                    '${wData.weather.currently}', context, 55),
              ),*/
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    toBeginningOfSentenceCase('${wData.weather.description}'),
                    overflow: TextOverflow.ellipsis,
                    style: _style1.copyWith(fontSize: 19,color: Colors.white),
                  ),
                  Text(
                    DateFormat('EEEE, dd MMM').format(DateTime.now()),
                    style: _style2,
                  ),
                ],
              ),
              SizedBox(width: 30,),
              Text(
                '${wData.weather.temp.toStringAsFixed(0)}°',
                style: TextStyle(
                  fontSize: 85,
                  fontWeight: FontWeight.w800,
                  color: Colors.blue
                ),
              ),
            ],
          ),
          /*Text(
            '${wData.weather.tempMax.toStringAsFixed(0)}°/ ${wData.weather.tempMin.toStringAsFixed(0)}° Feels like ${wData.weather.feelsLike.toStringAsFixed(0)}°',
            style: _style1.copyWith(fontSize: 19),
          ),*/

        ],
      ),
    );
  }
}
