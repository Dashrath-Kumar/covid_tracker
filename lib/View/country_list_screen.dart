import 'package:covid_tracker/View/detail_screen.dart';
import 'package:covid_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart'as http;
import 'package:shimmer/shimmer.dart';


class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  StateServices stateServices=StateServices();
  TextEditingController searchController=TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value){
                  setState(() {
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText:"Search by Countries Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  )
                ),
              ),
            ),
            Expanded(
                child:FutureBuilder(
                  future: stateServices.countriesListApi(),
                  builder: (context,AsyncSnapshot<List<dynamic>>snapshot){
                    if(!snapshot.hasData){
                      return ListView.builder(
                          itemCount: 4,//as we are loading for data so we will only show 4 list loading apperarance
                          itemBuilder:(context,index){
                            return Shimmer.fromColors(
                              baseColor:Colors.grey.shade700,
                              highlightColor:Colors.grey.shade200,
                              child: Column(
                                children: [
                                  ListTile(
                                    title:Container(height: 10,width: 80,color: Colors.white,),
                                    subtitle:Container(height: 10,width: 80,color: Colors.white,),
                                    leading: Container(height: 50,width: 50,color: Colors.white,),
                                  )
                                ],
                              ),
                            );
                          }
                      );
                    }else{
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder:(context,index){
                            String name=snapshot.data![index]['country'];// to take country name input filltering of name

                            if(searchController.text.isEmpty){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context)=>DetailScreen(
                                              image: snapshot.data![index]['countryInfo']['flag'],
                                              name: snapshot.data![index]['country'],
                                              totalCases: snapshot.data![index]['cases'],
                                              totalDeaths: snapshot.data![index]['deaths'],
                                              totalRecovered: snapshot.data![index]['recovered'],
                                              active: snapshot.data![index]['active'],
                                              critical: snapshot.data![index]['critical'],
                                              todayRecovered: snapshot.data![index]['todayRecovered'],
                                              test: snapshot.data![index]['tests']
                                          )));
                                    },
                                    child: ListTile(
                                      title:Text(snapshot.data![index]['country']),
                                      subtitle:Text("Cases:"+snapshot.data![index]['cases'].toString()),
                                      leading: Image(
                                        height:50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                              Column(
                                children: [
                                  InkWell(//when u search and then tap on the country for that tap
                                    onTap:(){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context)=>DetailScreen(
                                              image: snapshot.data![index]['countryInfo']['flag'],
                                              name: snapshot.data![index]['country'],
                                              totalCases: snapshot.data![index]['cases'],
                                              totalDeaths: snapshot.data![index]['deaths'],
                                              totalRecovered: snapshot.data![index]['recovered'],
                                              active: snapshot.data![index]['active'],
                                              critical: snapshot.data![index]['critical'],
                                              todayRecovered: snapshot.data![index]['todayRecovered'],
                                              test: snapshot.data![index]['tests']
                                          )));

                                    },
                                    child: ListTile(
                                      title:Text(snapshot.data![index]['country']),
                                      subtitle:Text("Cases:"+snapshot.data![index]['cases'].toString()),
                                      leading: Image(
                                        height:50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }else{
                              return Container();
                            }
                          }
                      );
                    }
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}
