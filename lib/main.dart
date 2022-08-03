import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tdeecalculator/functions.dart';
import 'package:tdeecalculator/output.dart';

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
  String? selectedHeight = "5ft 1in";
  final formKey = GlobalKey<FormState>();
  bool female = false;
  bool imperial = false;

  double? ageValue;
  double? weightValue;
  double? heightValue;
  double? bodyfatValue;
  double? idealWeight;

  double? bmr;
  double? tdee;
  double? finalTdee;
  double? bmi;


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

  List<DropdownMenuItem<String>> imperialHeights = const [
    DropdownMenuItem(value: "4ft 7in", child: Text("4ft 7in")),
    DropdownMenuItem(value: "4ft 8in", child: Text("4ft 8in")),
    DropdownMenuItem(value: "4ft 9in", child: Text("4ft 9in")),
    DropdownMenuItem(value: "4ft 10in", child: Text("4ft 10in")),
    DropdownMenuItem(value: "4ft 11in", child: Text("4ft 11in")),
    DropdownMenuItem(value: "5ft 0in", child: Text("5ft 0in")),
    DropdownMenuItem(value: "5ft 1in", child: Text("5ft 1in")),
    DropdownMenuItem(value: "5ft 2in", child: Text("5ft 2in")),
    DropdownMenuItem(value: "5ft 3in", child: Text("5ft 3in")),
    DropdownMenuItem(value: "5ft 4in", child: Text("5ft 4in")),
    DropdownMenuItem(value: "5ft 5in", child: Text("5ft 5in")),
    DropdownMenuItem(value: "5ft 6in", child: Text("5ft 6in")),
    DropdownMenuItem(value: "5ft 7in", child: Text("5ft 7in")),
    DropdownMenuItem(value: "5ft 8in", child: Text("5ft 8in")),
    DropdownMenuItem(value: "5ft 9in", child: Text("5ft 9in")),
    DropdownMenuItem(value: "5ft 10in", child: Text("5ft 10in")),
    DropdownMenuItem(value: "5ft 11in", child: Text("5ft 11in")),
    DropdownMenuItem(value: "6ft 0in", child: Text("6ft 0in")),
    DropdownMenuItem(value: "6ft 1in", child: Text("6ft 1in")),
    DropdownMenuItem(value: "6ft 2in", child: Text("6ft 2in")),
    DropdownMenuItem(value: "6ft 3in", child: Text("6ft 3in")),
    DropdownMenuItem(value: "6ft 4in", child: Text("6ft 4in")),
    DropdownMenuItem(value: "6ft 5in", child: Text("6ft 5in")),
    DropdownMenuItem(value: "6ft 6in", child: Text("6ft 6in")),
    DropdownMenuItem(value: "6ft 7in", child: Text("6ft 7in")),
    DropdownMenuItem(value: "6ft 8in", child: Text("6ft 8in")),
    DropdownMenuItem(value: "6ft 9in", child: Text("6ft 9in")),
    DropdownMenuItem(value: "6ft 10in", child: Text("6ft 10in")),
    DropdownMenuItem(value: "6ft 11in", child: Text("6ft 11in")),
    DropdownMenuItem(value: "7ft 0in", child: Text("7ft 0in")),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                Switch(
                    activeColor: Colors.white,
                    value: imperial,
                    onChanged: (value) {
                      setState(() {
                        imperial = value;
                      });
                    })
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(17, 17, 17, 0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(6))),

            height:
                470,
            width: size.width,
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
                                activeColor: Colors.blueGrey[700],
                                inactiveThumbColor: Colors.blueGrey,
                                inactiveTrackColor: Colors.blueGrey[200],
                                value: female,
                                onChanged: (value) {
                                  setState(() {
                                    female = value;
                                  });
                                },
                              ),
                              female == true
                                  ? const Text("Female")
                                  : const Text("Male")
                            ],
                          ),
                          numberBox(
                              160, "years", "age", 5, 100, false),
                          numberBox(160, imperial == false ? "Kg" : "lbs", "weight", imperial == false ? 35: 77,
                              imperial == false ? 300: 661, false),
                          imperial == false
                              ? numberBox(160, "cm", "height",
                                  100, 220, false)
                              : dropdownBox(imperialHeights, selectedHeight),
                          dropdownBox(activities, selectedActivity),
                          numberBox(60, "15%", "bodyfat", 3,
                              50, true),
                          dropdownBox(goals, selectedGoal),
                          submitButton(formKey)
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
        child: const Center(child: Text("")),
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

  Padding numberBox(
      double width,
      String labelText,
      String type,
      int minInput,
      int maxInput,
      bool optional) {
    String? numberValidator(String? value) {
      if (value == null) {
        return null;
      }
      final number = num.tryParse(value);

      if (number == null || number > maxInput || number < minInput) {
        if (optional == true) {
          return null;
        }
        return "Invalid Input";
      }
      switch (type) {
        case "age":
          ageValue = double.parse(value);
          break;
        case "weight":
          imperial == true? weightValue= double.parse(value) *0.453592 : weightValue = double.parse(value);
          break;
        case "height":
          heightValue = double.parse(value);
          break;
        case "bodyfat":
          bodyfatValue = double.parse(value);
          break;
      }
      female = false;
      return null;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: width,
        height: 43,
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          validator: numberValidator,
          obscureText: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            labelText: labelText,
          ),
        ),
      ),
    );
  }

  ElevatedButton submitButton(GlobalKey<FormState> key) {
    double genderIndex = female == true ? 655.0955 : 66.4730;
    double weightIndex = female == true ? 9.5634 : 13.7516;
    double heightIndex = female == true ? 1.8496 : 5.0033;
    double ageIndex = female == true ? 4.6756 : 6.7550;

    ageValue==null ? ageValue = 25 : null;
    weightValue == null ? weightValue = 70 : null;
    heightValue == null ? heightValue = 170 : null;
    bodyfatValue == null ? bodyfatValue = 0 : null;

    bmr == null ? bmr= 0 : null;
    tdee == null ? tdee = 0 : null;
    finalTdee == null ? finalTdee= 0 : null;
    bmi == null ? bmi = 0 : null;

    double idealWeight = female == true ? heightValue! - 100 - (heightValue! - 150) / 2 : heightValue! - 100 - (heightValue! - 150) / 4;

    return ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.blueGrey[700]),
          onPressed: () {
            imperial == true
                ? heightValue = imperialConversion(selectedHeight)
                : null;
            if (key.currentState!.validate()) {
              formValidate(context, bodyfatValue! ,weightValue!,weightIndex,idealWeight,heightValue!,heightIndex,ageValue!,ageIndex, genderIndex, selectedActivity, selectedGoal, tdee!,finalTdee!,bmr!, bmi!);
            }

          },
          child: const Text("Submit"));

  }

  Padding dropdownBox(
      List<DropdownMenuItem<String>> items, String? selectedValue) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: DropdownButton<String>(
          items: items,
          onChanged: (value) {
            if (selectedValue == selectedActivity) {
              setState(() {
                selectedActivity = value;
              });
            } else if (selectedValue == selectedActivity) {
              setState(() {
                selectedGoal = value;
              });
            } else if (selectedValue == selectedHeight) {
              setState(() {
                selectedHeight = value;
              });
            }
          },
          value: selectedValue,
        ));
  }


}
