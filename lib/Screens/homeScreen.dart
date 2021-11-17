import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../provider/weatherProvider.dart';
import '../widgets/WeatherInfo.dart';
import '../widgets/fadeIn.dart';
import '../widgets/hourlyForecast.dart';
import '../widgets/locationError.dart';
import '../widgets/mainWeather.dart';
import '../widgets/requestError.dart';
import '../widgets/searchBar.dart';
import '../widgets/weatherDetail.dart';
import '../widgets/sevenDayForecast.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  bool _isLoading;
  bool _isVisibleSearch = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future<void> _getData() async {
    _isLoading = true;
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    weatherData.getWeatherData();
    _isLoading = false;
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false).getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    final myContext = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: myContext.primaryColor,
                ),
              )
            : weatherData.loading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: myContext.primaryColor,
                    ),
                  )
                : weatherData.isLocationError
                    ? LocationError()
                    : Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(int.parse(
                                    '#5716ba'.replaceAll('#', '0xff'))),
                                Color(int.parse(
                                    '#4b21ca'.replaceAll('#', '0xff'))),
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 35,
                            ),
                            _isVisibleSearch
                                ? SearchBar(() {
                                    setState(() {
                                      _isVisibleSearch = false;
                                    });
                                  })
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 1,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isVisibleSearch = true;
                                          });
                                        },
                                        icon: Icon(Icons.location_city,
                                            color: Colors.white),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _isVisibleSearch = true;
                                          });
                                        },
                                        child: Text(
                                            '${weatherData.weather.cityName.toString().toUpperCase()}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Colors.white)),
                                      ),
                                      Icon(Icons.more_vert_rounded,
                                          color: Colors.white),
                                      SizedBox(
                                        width: 1,
                                      ),
                                    ],
                                  ),
                            /*SmoothPageIndicator(
                              controller: _pageController,
                              count: 2,
                              effect: ExpandingDotsEffect(
                                activeDotColor: myContext.primaryColor,
                                dotHeight: 6,
                                dotWidth: 6,
                              ),
                            ),*/
                            /*Container(color: Colors.red,child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('AHMEDABAD',style: TextStyle(fontSize: 24),),
                              ],
                            )),*/
                            weatherData.isRequestError
                                ? RequestError()
                                : Expanded(
                                    child: PageView(
                                      controller: _pageController,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: mediaQuery.size.width,
                                          child: RefreshIndicator(
                                            onRefresh: () =>
                                                _refreshData(context),
                                            backgroundColor: Colors.blue,
                                            child: ListView(
                                              children: [
                                                SizedBox(
                                                  height: 60,
                                                ),
                                                FadeIn(
                                                    delay: 0,
                                                    child: MainWeather(
                                                        wData: weatherData)),
                                                /*FadeIn(
                                                  delay: 0.33,
                                                  child: WeatherInfo(
                                                      wData: weatherData
                                                          .currentWeather),
                                                ),*/
                                                FadeIn(
                                                  delay: 0.66,
                                                  child: HourlyForecast(
                                                      weatherData
                                                          .hourlyWeather),
                                                ),
                                                FadeIn(
                                                  delay: 0.33,
                                                  child: SevenDayForecast(
                                                    wData: weatherData,
                                                    dWeather: weatherData
                                                        .sevenDayWeather,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        /*Container(
                                          height: mediaQuery.size.height,
                                          width: mediaQuery.size.width,
                                          child: ListView(
                                            children: [
                                              FadeIn(
                                                delay: 0.33,
                                                child: SevenDayForecast(
                                                  wData: weatherData,
                                                  dWeather:
                                                      weatherData.sevenDayWeather,
                                                ),
                                              ),
                                              FadeIn(
                                                  delay: 0.66,
                                                  child: WeatherDetail(
                                                      wData: weatherData)),
                                            ],
                                          ),
                                        ),*/
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
      ),
    );
  }
}
