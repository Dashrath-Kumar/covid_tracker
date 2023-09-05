import 'dart:convert';

import 'package:covid_tracker/services/utilities/app_url.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';

import '../model/WorldStatesModel.dart';


//&&&&this for to fetch data from the apis


class StateServices{
  //fetch data from services
  Future<WorldStatesModel>fetchWorldStatesRecords() async{
    //same code to fetch data from api
    final response=await http.get(Uri.parse(AppUrl.worldStatesApi));

    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
      //after this go to page of World_states to show data on pie chart

    }else{
      throw Exception("error");
    }
  }

  //fetch data for countries list without using modal
  Future<List<dynamic>>countriesListApi() async{
    //required to make universal variable
    var data;
    //same code to fetch data from api
    final response=await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode==200){
       data=jsonDecode(response.body);
      return data;
      //after this go to page of countries list to show list data
    }else{
      throw Exception("error");
    }
  }


}