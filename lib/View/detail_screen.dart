import 'package:flutter/material.dart';



class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,test;
   DetailScreen({super.key,
     required this.image,
     required this.name,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecovered,
     required this.active,
     required this.critical,
     required this.todayRecovered,
     required this.test,

   });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name,style: TextStyle(fontSize: 15.0),),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.06,),
                      ReusableRow(title:"Total Cases", value:widget.totalCases.toString()),
                      ReusableRow(title:"Total Deaths", value:widget.totalDeaths.toString()),
                      ReusableRow(title:"Total Recovered", value:widget.totalRecovered.toString()),
                      ReusableRow(title:"Total Active", value:widget.active.toString()),
                      ReusableRow(title:"Total Critical", value:widget.critical.toString()),
                      ReusableRow(title:"Total Test", value:widget.test.toString()),
                      ReusableRow(title:"Today Recovered", value:widget.todayRecovered.toString()),

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
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