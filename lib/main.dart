import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tdeecalculator/functions.dart';
import 'package:tdeecalculator/layout/elements.dart';
import 'layout/values.dart';


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


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    imperialCallBack(bool value) {
      setState(() {
        imperial = value;
      });
    }
    
    genderCallBack(bool value) {
      setState(() {
        female = value;
      });
    }

    dropCallBack(String parameter, String value) {
      if(parameter == selectedHeight) {
        setState(() {
          selectedHeight = value;
        });
      } else if(parameter == selectedActivity) {
        setState(() {
          selectedActivity = value;
        });
      } else if(parameter == selectedHeight) {
        setState(() {
          selectedHeight = value;
        });
      }
    }

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
                FormSwitch(parameter: imperial, callBackFunction: imperialCallBack, color1: Colors.orange[900], color2: Colors.blueGrey, color3: Colors.blueGrey[200],)
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
                              FormSwitch(parameter: female, callBackFunction: genderCallBack, color1: Colors.orange, color2: Colors.blueGrey, color3: Colors.blueGrey[200]),
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
                              : ChoiceBox(list: imperialHeights, selectedValue: selectedHeight,callBackFunction: dropCallBack),
                          ChoiceBox(list: activities, selectedValue: selectedActivity, callBackFunction: dropCallBack),
                          numberBox(60, "15%", "bodyfat", 3,
                              50, true),
                          ChoiceBox(list: goals, selectedValue: selectedGoal, callBackFunction: dropCallBack),
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

    double genderIndex = genderIndexParameter(female);
    double weightIndex = weightIndexParameter(female);
    double heightIndex = heightIndexParameter(female);
    double ageIndex = ageIndexParameter(female);

    ageValue = standardValue(ageValue, 25);
    weightValue = standardValue(weightValue, 70);
    bodyfatValue = standardValue(bodyfatValue, 0);
    bmr = standardValue(bmr, 0);
    tdee = standardValue(tdee, 0);
    finalTdee = standardValue(finalTdee, 0);
    bmi = standardValue(bmi, 0);


    double idealWeight = idealWeightParameter(female, heightValue);

    return ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.blueGrey[700]),
          onPressed: () {
            imperial == true
                ? heightValue = imperialConversion(selectedHeight)
                : null;
            if (key.currentState!.validate()) {
              formValidate(context, bodyfatValue! ,weightValue!,weightIndex,idealWeight,heightValue!,heightIndex,ageValue!,ageIndex, genderIndex, selectedActivity, selectedGoal, tdee!,finalTdee!,bmr!, bmi!);
            }
            bodyfatValue = 0;
          },
          child: const Text("Submit"));

  }


}
