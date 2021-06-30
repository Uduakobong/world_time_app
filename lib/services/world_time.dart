import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;//location property for the ui
  String time;//declare time in location
  String flag;//url to asset flag icon
  String url;//url for API endpoint
  bool isDaytime;//evaluates true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

    try {
      //make time request for location
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //next,get properties from obtained data: datetime and utc_offset
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print(datetime);
      //print(offset);

      //next create DateTime object
      DateTime now = DateTime.parse(datetime);
      now= now.add(Duration (hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('caught error: $e');
      time = 'Could not get time data';
    }
  }

}


