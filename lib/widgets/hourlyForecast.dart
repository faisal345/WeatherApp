import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/utils.dart';
import '../Screens/hourlyWeatherScreen.dart';
import '../models/dailyWeather.dart';

class HourlyForecast extends StatelessWidget {
  final List<DailyWeather> hourlyForecast;

  HourlyForecast(this.hourlyForecast);

  Widget hourlyWidget(dynamic weather, BuildContext context) {
    final currentTime = weather.date;
    final hours = DateFormat.Hm().format(currentTime);

    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(int.parse(
            '#5c3bcf'.replaceAll('#', '0xff'))),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 4,
            blurRadius: 8,
            offset: Offset(0, 10),
          ),
        ],
      ),
      height: 175,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  hours,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: MapString.mapStringToIcon(
                      '${weather.condition}', context, 40),
                ),
                Column(
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        "${weather.condition}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: 80,
                      child: Text(
                        "${weather.dailyTemp.toStringAsFixed(1)}°C",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  children: [
                    Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(width: 20,),
                    Text(
                      'Tomorrow',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue
                      ),
                    ),
                  ],
                ),
              ),
              /*TextButton(
                child: Text(
                  'See More',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(HourlyScreen.routeName);
                },
              ),*/
            ],
          ),
          SizedBox(height: 20),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: hourlyForecast
                  .map((item) => hourlyWidget(item, context))
                  .toList()),
        ],
      ),
    );
  }
}
