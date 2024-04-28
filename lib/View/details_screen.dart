

import 'package:covid_19_tracker/View/world_states.dart';
import 'package:flutter/material.dart';
class DetailsScreen extends StatefulWidget {
  String image,name;
  int totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,test;
   DetailsScreen({
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
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.06,),
                      ReusableRow(title: 'Total Cases', value: widget.totalCases.toString()),
                      ReusableRow(title: 'Total Tests', value: widget.test.toString()),
                      ReusableRow(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                      ReusableRow(title: 'Total Deaths', value: widget.totalDeaths.toString()),
                      ReusableRow(title: 'Total Active', value: widget.active.toString()),



                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
