import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/utils.dart';
import '../models/dailyWeather.dart';

class SevenDayForecast extends StatelessWidget {
  final wData;
  final List<DailyWeather> dWeather;

    SevenDayForecast({this.wData, this.dWeather});

  Widget dailyWidget(dynamic weather, BuildContext context) {
    final currentTime = weather.date;
    final hours = DateFormat.Hm().format(currentTime);
    final dayOfWeek = DateFormat('MMM, dd').format(weather.date);

    return Row(
      children: [
        SizedBox(width: 10,),
        Container(
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
                    FittedBox(
                      child: Text(
                        dayOfWeek ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
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
        ),
      ],
    );
  }

  /*Widget dailyWidget(dynamic weather, BuildContext context) {
    final dayOfWeek = DateFormat('MMM, dd').format(weather.date);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: [
          FittedBox(
            child: Text(
              dayOfWeek ?? '',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 20),
            child:
                MapString.mapStringToIcon('${weather.condition}', context, 35),
          ),
          Text(
            '${weather.condition}',
          ),
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    /*return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 35, left: 20),
          child: Text(
            '7 - Day weather report',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),
        *//*SizedBox(height: 10,),
        SizedBox(height: 15),*//*
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Row(
                children: dWeather
                    .map((item) => dailyWidget(item, context))
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );*/


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
                padding: const EdgeInsets.only(top: 40, left: 10),
                    child : Text(
                      '7 - Day weather report',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
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
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: dWeather
                    .map((item) => dailyWidget(item, context))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
