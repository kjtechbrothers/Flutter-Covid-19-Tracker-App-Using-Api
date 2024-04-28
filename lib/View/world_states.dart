
import 'package:covid_19_tracker/Model/world_states_model.dart';
import 'package:covid_19_tracker/Services/states_services.dart';
import 'package:covid_19_tracker/View/countries_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with TickerProviderStateMixin {

  late final AnimationController _controller=AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  final colorList=<Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.01,),
              FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStatesModel>snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                    flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ) );
                }
                else{
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total":double.parse(snapshot.data!.cases.toString()),
                          "Recovered":double.parse(snapshot.data!.recovered.toString()),
                          "Deaths":double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                        animationDuration: const Duration(milliseconds: 1200),
                        chartRadius: MediaQuery.of(context).size.height/3.2,
                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left
                        ),
                        chartType: ChartType.ring,
                        colorList: colorList,),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(title: 'Cases', value: snapshot.data!.cases.toString()),
                              ReusableRow(title: 'Tests', value: snapshot.data!.tests.toString()),
                              ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                              ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                              ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                              ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                              ReusableRow(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountriesListScreen()));
                        },
                        child: Container(
                          height: 50,
                          decoration:  BoxDecoration(
                            color: const Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text('Track Countries'),
                          ),
                        ),
                      ),
                    ],
                  );

                }
              }),

            ],
          ),
        ),
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title,value;
   ReusableRow({Key? key, required this.title,required this.value}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5,),
          const Divider(),
        ],
      ),
    );
  }
}

