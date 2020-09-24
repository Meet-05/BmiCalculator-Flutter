import 'package:bmiApp/screens/result_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmiApp/components/reusableWidget.dart';

import 'package:bmiApp/components/bottom_button.dart';
import 'package:bmiApp/components/dataForIcon.dart';
import 'package:bmiApp/constants.dart';
import 'package:bmiApp/components/round_iconbutton.dart';
import 'package:bmiApp/bmi_brain.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  int height = 180;
  int weight = 60;
  int age = 10;
  Gender selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bmi Calculator'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: ReusableWidget(
                    colour: selectedGender == Gender.male
                        ? kactiveCardColor
                        : kinactiveCardColor,
                    cardData: DataForIcon(
                      gender: 'Male',
                      icon: FontAwesomeIcons.mars,
                    ),
                    handleTap: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                  ),
                ),
                Expanded(
                    child: ReusableWidget(
                  colour: selectedGender == Gender.female
                      ? kactiveCardColor
                      : kinactiveCardColor,
                  cardData: DataForIcon(
                    gender: 'Female',
                    icon: FontAwesomeIcons.venus,
                  ),
                  handleTap: () {
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                )),
              ],
            )),
            Expanded(
                child: ReusableWidget(
              colour: kactiveCardColor,
              cardData: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Height',
                    style: kLableTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        style: kNumberStyle,
                      ),
                      Text(
                        'cm',
                        style: kLableTextStyle,
                      ),
                    ],
                  ),
                  SliderTheme(
                    //use the default theme for slider but customize some parameters
                    data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        activeTrackColor: Colors.white,
                        thumbColor: Colors.pink,
                        overlayColor: Color(
                            0x29EB1555), //first two caharcters set opacity
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30.0)),
                    child: Slider(
                        value: height.toDouble(),
                        min: 110.0,
                        max: 220.0,
                        activeColor: Colors.pink,
                        inactiveColor: Colors.white,
                        onChanged: (double value) {
                          setState(() {
                            height = value.round();
                          });
                        }),
                  ),
                ],
              ),
            )),
            Expanded(
                child: Row(
              children: [
                Expanded(
                    child: ReusableWidget(
                  colour: kactiveCardColor,
                  cardData: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Weight',
                        style: kLableTextStyle,
                      ),
                      Text(
                        weight.toString(),
                        style: kNumberStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: () {
                              setState(() {
                                weight++;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: () {
                              setState(() {
                                weight--;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )),
                Expanded(
                  child: ReusableWidget(
                    colour: kactiveCardColor,
                    cardData: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Age',
                          style: kLableTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
            BottomButton(
              onPressed: () {
                BmiBrain calcBmi = BmiBrain(height: height, weight: weight);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultPage(
                              bmiValue: calcBmi.calculateBmi(),
                              result: calcBmi.getResult(),
                              interpretation: calcBmi.geInterpretation(),
                            )));
                // Navigator.pushNamed(context, '/result');
              },
              labelText: 'Calculate',
            )
          ],
        ));
  }
}

//creating our own widget from scratch
