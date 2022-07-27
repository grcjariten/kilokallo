import 'package:flutter/material.dart';

void main() {

  runApp(
      const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TDEE Calculator",
      home: MainPage(),
    );
  }
}



class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  String? selectedActivity = "Sedentary";
  String? selectedGoal = "Maintain";
  final formKey = GlobalKey<FormState>();


  List<DropdownMenuItem<String>> activities =  const [
    DropdownMenuItem(value: "Sedentary", child: Text("Sedentary")),
    DropdownMenuItem(value: "Light", child: Text("Light Activity")),
    DropdownMenuItem(value: "Moderate", child: Text("Moderate Activity")),
    DropdownMenuItem(value: "High", child: Text("High Activity")),
    DropdownMenuItem(value: "Elite", child: Text("Elite"))];

  List<DropdownMenuItem<String>> goals =  const [
    DropdownMenuItem(value: "Maintain", child: Text("Maintain")),
    DropdownMenuItem(value: "Lose", child: Text("Lose")),
    DropdownMenuItem(value: "Gain", child: Text("Gain"))];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blueGrey[300],
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[700],
          toolbarHeight: 80,
          title: const Text("TDEE Calculator"),
          centerTitle: true,
          actions: [
            metricImperial(),
              ],
            ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(17,12,17,0),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(6))
                ),

                height: 540, //TODO: Mettere altezza e larghezza in relazione allo schermo
                width: 400,
                child:
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18,8,0,5),
                      child:
                          Form(
                            key: formKey,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    fieldText("Gender",16),
                                    fieldText("Age" , 12),
                                    fieldText("Weight" , 29),
                                    fieldText("Height" , 17),
                                    fieldText("Activity" , 27),
                                    fieldText("BodyFat\n(Opt.)" , 8),
                                    fieldText("Goal" , 25),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 13),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: const [
                                          Switch(value: false, onChanged: null),
                                          Text("Man")
                                        ],
                                      ),
                                      fieldBox(60, "", null, false),
                                      fieldBox(60, "Kg", null, false),
                                      fieldBox(60, "cm", null, false),
                                      dropdownBox(activities, selectedActivity),
                                      fieldBox(60, "15%", null, true),
                                      dropdownBox(goals, selectedGoal),
                                      calculateButton(formKey)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),


                    ),




              ),
            ),
          ),

      bottomNavigationBar: Container(
        height: 70,
        color: Colors.blueGrey,
        child: const Center(child: Text("Banner Admob")),
      ),
    );
  }

  Column metricImperial() {
    return Column(
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 13.0, 9, 0),
            child: Text("Metric/Imperial"),
          ),
          Switch(value: false, onChanged: null)
        ]
    );

  }

  Padding fieldText(String text, double padding) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, padding, 0, padding),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold),),
    );
  }

  Padding ageBox(double width, String labelText, function) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: width,
        height: 43,
        child: TextFormField(

          validator: (value) {
            if (value == null || value.isEmpty) {
                return 'Pleaseeeeeeeeeeeeeee';
            }
            return null;
          },
          obscureText: false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
          ),
        ),

      ),

    );
  }

  Padding fieldBox(double width, String labelText, function, bool optional) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
              width: width,
              height: 43,
              child: TextFormField(

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    if(optional==false) {
                      return '* Required field';
                    }
                  }
                  return null;
                },
                obscureText: false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: labelText,
                ),
            ),

            ),

    );
  }

  Padding calculateButton(GlobalKey<FormState> key) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blueGrey[700]
          ),
          onPressed: () {
            if(key.currentState!.validate()) {
              //TODO: Inserire calcolo
            }

          }, child: const Text("Calculate")),
    );

  }

   Padding dropdownBox(List<DropdownMenuItem<String>> items, String? selectedValue) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButton<String>(
          items: items,
          onChanged: (value) {
            selectedValue==selectedActivity?
            setState(() {
              selectedActivity = value;
            })
            : setState(() {
              selectedGoal = value;
            });

          },
          value: selectedValue,
        )
    );
  }
}

