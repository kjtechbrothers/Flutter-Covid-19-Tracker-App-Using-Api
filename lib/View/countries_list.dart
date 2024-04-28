import 'package:covid_19_tracker/View/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid_19_tracker/Services/states_services.dart';
import 'package:shimmer/shimmer.dart';
class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController=SearchController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value){
                setState(() {

                });
              },
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search with country name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                )
              ),
            ),
          ),
          Expanded(
              child:FutureBuilder(
                future: statesServices.countriesListApi(),
                builder: (context,AsyncSnapshot<List<dynamic>>snapshot){
                  if(!snapshot.hasData){
                    return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context,index){
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(height: 10,width: 89,color: Colors.white,),
                                  subtitle: Container(height: 10,width: 89,color: Colors.white,),
                                  leading: Container(height: 50,width: 50,color: Colors.white,),
                                )

                              ],
                            ) ,);

                        });
                  }
                  else{
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context,index){
                          String name=snapshot.data![index]['country'];
                          if(searchController.text.isEmpty){
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen(
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  name: snapshot.data![index]['country'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalRecovered: snapshot.data![index]['recovered'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  active: snapshot.data![index]['active'],
                                  test: snapshot.data![index]['tests'],
                                  critical: snapshot.data![index]['critical'],
                                  todayRecovered: snapshot.data![index]['todayRecovered'],


                                )));
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                  )

                                ],
                              ),
                            );
                          }
                          else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen(
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        name: snapshot.data![index]['country'],
                                        totalCases: snapshot.data![index]['cases'],
                                        totalRecovered: snapshot.data![index]['recovered'],
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        active: snapshot.data![index]['active'],
                                        test: snapshot.data![index]['tests'],
                                        critical: snapshot.data![index]['critical'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                    )));
                                    },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                  ),
                                )

                              ],
                            );
                          }
                          else{
                            return Container();
                          }

                    });
                  }

                },
              ) )
        ],
      ),
    );
  }
}
