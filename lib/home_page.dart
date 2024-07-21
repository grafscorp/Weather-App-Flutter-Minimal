import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

const OPEN_WEATHER_API_KEY = 'a66c202a7ef3e492b5c091eccf6250c3';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Weather? todayWeather;
  List<Weather>? fiveDaysWeather;
  final WeatherFactory _weatherFactory = WeatherFactory(OPEN_WEATHER_API_KEY);
  @override
  void initState() {
    super.initState();
    getWeatherByCity("Moscow");
  }

  void getWeatherByCity(String city) async {
    await _weatherFactory.fiveDayForecastByCityName(city).then((onValue) {
      setState(() {
        print(onValue);
        fiveDaysWeather = onValue;
      });
    });
    todayWeather = fiveDaysWeather?[0];
  }

  TextStyle _defaultTextStyle({double fontSize_ = 24.0}) {
    return TextStyle(
        fontSize: fontSize_,
        color: Colors.black,
        shadows: const [
          Shadow(
              color: Color.fromARGB(245, 144, 144, 144),
              blurRadius: 3.0,
              offset: Offset(2, 2))
        ],
        decoration: TextDecoration.none);
  }

  @override
  Widget build(BuildContext context) {
    if (todayWeather == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );
    }
    return Container(
      ///Decoration
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black, Colors.white, Colors.white],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter)),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 60.0, right: 50, left: 50),
        child: Column(
          ///Main Widgets
          children: [
            titleLocation,
            const SizedBox(
              height: 20.0,
            ),
            weatherInfoToday,
            const SizedBox(
              height: 20.0,
            ),
            futureDataWeatherWrap
          ],
        ),
      )),
    );
  }

// Widget City Location Info
  Widget get titleLocation => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on_rounded,
          ),

          ///City Text Widget
          Text(
            todayWeather?.areaName ?? "Loading",
            style: _defaultTextStyle(),
          )
        ],
      );

//Main Weather Info
  Widget get weatherInfoToday => Container(
        width: 256,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(width: 4.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ///Weather Icon
              const Icon(
                Icons.sunny,
                size: 100,
              ),

              ///Weather Now Temp
              Text("${todayWeather?.temperature?.celsius?.toStringAsFixed(0)}",
                  style: _defaultTextStyle(fontSize_: 32.0)),
              //Max Min Temp
              max_minTempToday,
              const Divider(),
              addInformationWeather(Icons.wind_power_rounded, "wind speed",
                  valueDataWeather: todayWeather?.windSpeed?.toStringAsFixed(2),
                  unitDataValue: "m/s"),
              addInformationWeather(
                Icons.cloud_rounded,
                "cloudness",
                valueDataWeather: todayWeather?.cloudiness?.toStringAsFixed(0),
              ),
              addInformationWeather(
                Icons.water_drop_rounded,
                "humidity",
                valueDataWeather: todayWeather?.humidity?.toStringAsFixed(0),
              ),
              addInformationWeather(Icons.remove_red_eye_rounded, "visible",
                  valueDataWeather: "00"),
              addInformationWeather(Icons.date_range_rounded,
                  "${todayWeather?.date?.day}.${todayWeather?.date?.month}.${todayWeather?.date?.year}",
                  secondColumn: false),
            ],
          ),
        ),

        //add information
      );
//Maximum and Minimum temp
  Widget get max_minTempToday {
    const fontSizeMaxMinTemp = 16.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${todayWeather?.tempMax?.celsius?.toStringAsFixed(0)}C",
            style: _defaultTextStyle(fontSize_: fontSizeMaxMinTemp)),
        const VerticalDivider(
          width: 4.0,
          color: Colors.black,
          thickness: 20,
          endIndent: 10,
        ),
        Text("${todayWeather?.tempMin?.celsius?.toStringAsFixed(0)}C",
            style: _defaultTextStyle(fontSize_: fontSizeMaxMinTemp)),
      ],
    );
  }

  Widget addInformationWeather(IconData iconDataWeather, String nameDataWeather,
      {String? valueDataWeather = "",
      bool secondColumn = true,
      String unitDataValue = "%"}) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  //Icon Data
                  Icon(iconDataWeather),
                  Text(
                    nameDataWeather,
                    style: _defaultTextStyle(fontSize_: secondColumn ? 20 : 24),
                  )
                ],
              ),
            ],
          ),
        ),
        secondColumn
            ? Column(
                children: [
                  //Value Data
                  Text(
                    "${valueDataWeather} ${unitDataValue}",
                    style: _defaultTextStyle(fontSize_: 14),
                  )
                ],
              )
            : Row()
      ],
    );
  }

  Widget get futureDataWeatherWrap {
    return Wrap(
      spacing: 30.0,
      runSpacing: 20.0,
      children: [
        futureWeatherCard(),
        futureWeatherCard(),
        futureWeatherCard(),
        futureWeatherCard(),
      ],
    );
  }

  Widget futureWeatherCard() {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //Icon Future Weather
            Container(
              //width: 36.0,
              height: 36.0,
            ),
            //Temp Future Weather
            Text(
              " C",
              style: _defaultTextStyle(fontSize_: 14),
            ),
            const Divider(),
            //Date Future Weather
            Text("date", style: _defaultTextStyle(fontSize_: 14))
          ],
        ),
      ),
    );
  }
}
