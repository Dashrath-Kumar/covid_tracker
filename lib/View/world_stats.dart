import 'package:covid_tracker/View/country_list_screen.dart';
import 'package:covid_tracker/model/WorldStatesModel.dart';
import 'package:covid_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'dart:math'as math;
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({super.key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin{
  //TickerProviderStateMixin this help to build animation
  late final AnimationController _controller=AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
final colorList=<Color>[
  const Color(0xff4285F9),
  const Color(0xff1aa260),
  const Color(0xffde5246),
];


  @override
  Widget build(BuildContext context) {
    //taking this from state_services page to show data on pie chart
    StateServices stateServices=StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.01,),
              FutureBuilder(
                  future:stateServices.fetchWorldStatesRecords(),
                  builder:(context,AsyncSnapshot<WorldStatesModel>snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                        flex: 1,
                          child:SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          )
                      );
                    }else{
                      return Column(
                        children: [
                          PieChart(
                            chartRadius: MediaQuery.of(context).size.width/3.2,
                            dataMap:{
                              //maps takes value in double so string converted into double
                              "Total":double.parse(snapshot.data!.cases.toString()),
                              "Recovered":double.parse(snapshot.data!.recovered.toString()),
                              "Death":double.parse(snapshot.data!.deaths.toString())
                            },
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartType: ChartType.ring,
                            animationDuration: Duration(milliseconds: 1200),
                            colorList: colorList,
                            legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left
                            ),
                          ),
                          SizedBox(height:MediaQuery.of(context).size.height*.06),
                          Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*.01),
                              child: Column(
                                children: [
                                  ReusableRow(title: "Total Cases" ,value:snapshot.data!.cases.toString()),
                                   ReusableRow(title: "Today Cases", value:snapshot.data!.todayCases.toString()),
                                   ReusableRow(title: "Total Active Cases" ,value:snapshot.data!.active.toString()),
                                   ReusableRow(title: "Recovered" ,value:snapshot.data!.recovered.toString()),
                                  ReusableRow(title: "Critical" ,value:snapshot.data!.critical.toString()),
                                  ReusableRow(title: "Total Deaths" ,value:snapshot.data!.deaths.toString()),
                                  ReusableRow(title: "Today Death" ,value:snapshot.data!.todayDeaths.toString()),
                                  ReusableRow(title: "Total Recovered" ,value:snapshot.data!.todayRecovered.toString()),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 40.0,),
                          SizedBox(
                            height: 40.0,
                            width: double.infinity,
                            child: Padding(
                              padding:  EdgeInsets.only(left :18.0,right: 18.0),
                              child: ElevatedButton(onPressed:(){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>CountriesList()));
                              },
                                  child:Text("Track According to Countries")

                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ReusableRow extends StatelessWidget {
  String title;
  String value;
   ReusableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10.0,
          bottom: 5.0,top: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider(),
        ],
      ),
    );
  }
}
