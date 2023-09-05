//app url class for all API url to not forget about it


class AppUrl{
  //this is base url
  static const String baseUrl="https://disease.sh/v3/covid-19/";

  //fetch world covid stats
static const String worldStatesApi=baseUrl + 'all';
static const String countriesList=baseUrl + 'countries';

}

//after creating modal by using api from postman go to the statesservices
//to fetch data from api