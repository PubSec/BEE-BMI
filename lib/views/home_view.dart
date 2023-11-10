import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _weightcontroller = TextEditingController();
  final _heightcontroller = TextEditingController();

  int height = 0;
  num weight = 0;
  int result = 0;

  String bmiTable = '''
  Legend:

  Underweight < 18.5
  Healthy Weight 18.5-24.9
  Overweight 25-29.9
  Obese 30-34.9
  Severely Obese 35-39.9
  Morbidly Obese >= 40

''';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScopeNode();
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        // when user tap anywhere on the screen the keyboard you lose focus.
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.calculate_outlined,
          ),
          actions: [
            // without the Iconbutton first there is an error. this is an easier way to do it
            IconButton(
              onPressed: () {
                showDialog(
                  context: (context),
                  builder: (context) => AlertDialog(
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.clear),
                      )
                    ],
                    title: const Text('BMI Legend'),
                    content: SelectableText(
                      bmiTable,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.info_outline_rounded),
            )
          ],
          title: const Text(
            'BMI Calculator',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 100,
          // Gives round shape at the corner of the app bar
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
          child: Column(
            children: [
              Text(
                _weightcontroller.value.text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 14.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                // set controller
                controller: _weightcontroller,
                //input only numbers
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter your weight in kg',
                  suffixText: 'kg',
                  hintText: "example: 75",
                  filled: true,
                  fillColor: Colors.grey,
                ),
              ),
              Text(
                _heightcontroller.value.text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: _heightcontroller,
                decoration: const InputDecoration(
                  labelText: 'Enter your height in cm',
                  hintText: 'example: 175',
                  suffixText: 'cm',
                  fillColor: Colors.grey,
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.greenAccent),
                  //to make the button clickable everywhere. this was necessary if the button was in a container
                  maximumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 50)),
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 50)),
                ),
                onPressed: () {
                  setState(() {
                    weight = num.parse(_weightcontroller.value.text);
                    height = int.parse(_heightcontroller.value.text);
                  });
                  calculateBmi(height: height, weight: weight);
                },
                child: const Text(
                  'Calculate',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                height: 120,
                width: 500,
                child: Text(
                  '''
        
        Your BMI: $result
                    ''',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  num calculateBmi({required int height, required num weight}) {
    num results = weight / (height * height / 10000);
    setState(() {
      result = results.toInt();
    });

    return result.floor();
  }
}
