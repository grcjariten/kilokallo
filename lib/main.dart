import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
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
  bool female = false;
  bool imperial = false;
  int ageValue = 25;
  int weightValue = 70;
  int heightValue = 170;
  int bodyfatValue = 0;

  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController bodyfatController = TextEditingController();

  List<DropdownMenuItem<String>> activities = const [
    DropdownMenuItem(value: "Sedentary", child: Text("Sedentary")),
    DropdownMenuItem(value: "Light", child: Text("Light Activity")),
    DropdownMenuItem(value: "Moderate", child: Text("Moderate Activity")),
    DropdownMenuItem(value: "High", child: Text("High Activity")),
    DropdownMenuItem(value: "Elite", child: Text("Elite"))
  ];

  List<DropdownMenuItem<String>> goals = const [
    DropdownMenuItem(value: "Maintain", child: Text("Maintain")),
    DropdownMenuItem(value: "Lose", child: Text("Lose")),
    DropdownMenuItem(value: "Gain", child: Text("Gain"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blueGrey[300],
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.blueGrey[700],
        title: const Text("TDEE Calculator"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 10, 0),
            child: Column(
              children: [
                const Text("Metric/Imperial"),
                Switch(value: imperial, onChanged: (value) {
                  setState(() {
                    value == false ? imperial = false : imperial = true;
                    print(imperial);
                  });

                })
              ],

            ),
          ),

        ],

      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(17, 12, 17, 0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(6))),

            height:
                540, //TODO: Mettere altezza e larghezza in relazione allo schermo
            width: 400,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 0, 5),
              child: Form(
                key: formKey,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldText("Gender", 16),
                        fieldText("Age", 12),
                        fieldText("Weight", 29),
                        fieldText("Height", 17),
                        fieldText("Activity", 27),
                        fieldText("BodyFat\n(Opt.)", 8),
                        fieldText("Goal", 25),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Switch(
                                value: female,
                                onChanged: (value) {
                                  setState(() {
                                    value == false ? female = false : female = true;

                                  });
                                },
                              ),
                              female == true
                                  ? const Text("Female")
                                  : const Text("Male")
                            ],
                          ),
                          numberBox(160, "25", "age", ageController, 5, 100, false),
                          numberBox(160, "Kg", "weight", weightController, 35, 250, false),
                          numberBox(160, "cm", "height", heightController, 100, 220, false),
                          dropdownBox(activities, selectedActivity),
                          numberBox(60, "15%", "bodyfat", bodyfatController, 3, 50, true),
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

  Padding fieldText(String text, double padding) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, padding, 0, padding),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding numberBox(double width, String labelText, String type, TextEditingController controller, int minInput, int maxInput, bool optional) {
    String? numberValidator(String? value) {
      if(value==null) {
        return null;
      }
      final number= num.tryParse(value);

        if (number == null || number > maxInput || number < minInput) {
          if(optional==true) {
            return null;
          }
          return "Invalid Input";
        }
        switch(type) {

          case "age": ageValue = int.parse(value);
          break;
          case "weight": weightValue = int.parse(value);
          break;
          case "height": heightValue = int.parse(value);
          break;
          case "bodyfat": bodyfatValue = int.parse(value);
          break;
        }
      controller.clear();
      female = false;
      return null;
    }

  return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: width,
        height: 43,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          validator: numberValidator,
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

    double genderIndex = female == true ? 655 : 66;
    double weightIndex = female == true ? 9.6 : 13.7;
    double heightIndex = female == true ? 1.8 : 5;
    double ageIndex = female == true ? 4.7 : 6.8;

    double activityIndex() {

      switch(selectedActivity) {
      case "Sedentary" : return 1.2;
      case "Light" : return 1.375;
      case "Moderate" : return 1.55;
      case "High" : return 1.725;
      case "Elite" : return 1.9;
    }
      return 1.2;
    }

    double goalTdee(double tdee) {
      if(selectedGoal=="Lose") {
        return tdee - (tdee * 0.2);
      } else if(selectedGoal=="Gain") {
        return tdee + 200;
      } else {
        return tdee;
      }
    }


    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.blueGrey[700]),
          onPressed: () {
            double bmr;
            if (key.currentState!.validate()) {
              bodyfatValue == 0 ? bmr = genderIndex + (weightIndex * weightValue) + (heightIndex * heightValue) - (ageIndex * ageValue)
              : bmr= 370 + (21.6 * weightValue * (100 - bodyfatValue)/100);
              double tdee = bmr * activityIndex();
              double finalTdee = goalTdee(tdee);
              print("BMR is $bmr");
              print("TDEE is $tdee");
              print("goal TDEE is $finalTdee");
              bodyfatValue = 0;
            }
          },
          child: const Text("Calculate")),
    );
  }

  Padding dropdownBox(
      List<DropdownMenuItem<String>> items, String? selectedValue) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: DropdownButton<String>(
          items: items,
          onChanged: (value) {
            selectedValue == selectedActivity
                ? setState(() {
                    selectedActivity = value;
                  })
                : setState(() {
                    selectedGoal = value;
                  });
          },
          value: selectedValue,
        ));
  }
}
