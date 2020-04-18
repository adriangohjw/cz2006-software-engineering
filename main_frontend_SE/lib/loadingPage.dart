import 'package:flutter/material.dart';
import 'dart:math';

class LoadingPage extends StatelessWidget {
  List didyk = [
    "The world bicycle started being used several years after first bicycles appeared for sale. Those first models were called velocipedes.",
    'First bicycles were created in France, but its modern design was born in England.',
    'Inventors who first conceived modern bicycles were either blacksmiths or cartwrights.',
    'Over 100 million bicycles are manufactured each year.',
    'First commercially sold bicycle “Boneshaker” weighed 80 kg when it appeared for sale in 1868 in Paris.',
    'More than 100 years later after first bicycle was brought into China, this country now has over half a billion of them.',
    '5% of all trips in United Kingdom is made with bicycle. In United States this number is lower than 1%, but Netherlands has it at staggering 30%.',
    'Seven out of eight people in Netherlands that is older than 15 year old has a bicycle.',
    'Fastest measured speed of driving bicycle on a flat surface is 133.75 km/h.',
    'Popular bicycle type BMX was created in 1970s as a cheaper alternative to motocross races. Today they can be found all around the world.',
    'First bicycle-like transportation device was created in 1817 by German baron Karl von Drais. His design became known as draisine or dandy horse, but it was quickly replaced with more advanced velocipede designs that had pedal-driven transmission.',
    'Three most famous types of bicycle in the first 40 years of bicycle history were French Boneshaker, English penny-farthing and Rover Safety Bicycle.',
    'There are over 1 billion bicycles currently being used all around the world.',
    'Cycling as a popular pastime and competitive sport was established during late 19th century in England.',
    'Bicycles save over 238 million gallons of gas every year.',
    'Smallest bicycle ever made has wheels of the size of silver dollars.',
    'Most famous bicycle race in the world is the Tour de France which was established in 1903 and is still driven each year when cyclist from all over the world take part in 3 week event that is finished in Paris.',
    'The world bicycle is created from the French word “bicyclette”. Before this name, bicycles were known as velocipedes.',
    '1 year maintenance cost for bicycle is over times 20 cheaper than for a single car.',
    'One of the most important discoveries in the history of bicycle was pneumatic tire. This invention was made by John Boyd Dunlop in 1887.',
    'Cycling is one of the best pastimes for people who want to reduce risk of having heart disease and stroke.',
    'E-Bikes are very popular because they make daily commutes much easier.',
    'Bicycles can have more than one seat. Most popular configuration is two-seater tandem bike, but record holder is 67 feet long bicycle that was driven by 35 people.',
    'In 2011, Austrian racing cyclist Markus Stöckl drove an ordinary bicycle down the hill of a volcano. He attained the speed of 164.95 km/h.',
    'One car parking space can hold between 6 and 20 parked bicycles.',
    'First rear-wheel powered bicycle design was created by the Scottish blacksmith Kirkpatrick.',
    'Fastest speed attained on bicycle that was driven on flat terrain with the help of pace car that removed wind turbulence was 268 km/h. This was achieved by Fred Rompelberg in 1995.',
    'Over 90% of all bicycle trips are shorter than 15 kilometers.',
    'Daily 16 kilometer ride (10 miles) burns 360 calories, saves up to 10 euros of budget and saves the environment from 5 kilos of carbon dioxide emissions that are produced by cars.',
    'Bicycles are more efficient in transforming energy to travel than cars, trains, airplanes, boats, and motorcycles.',
    'United Kingdom is home to over 20 million bicycles.',
    'Same energy that is expended for walking can be used with bicycle for x3 increase of speed.',
    'Fist cyclist that drove his bicycle around the world was Fred A. Birchmore. He pedaled for 25,000 miles and traveled other 15,000 miles by boat. He wore out 7 sets of tires.',
    'Energy and resources that are used for creation of one single car can be used for creation of up to 100 bicycles.',
    'Fist Mountain Bikes were made in 1977.',
    'United States is the home of over 400 cycling clubs.',
    '10% of New York City’s workforce commutes daily on bicycles.',
    '36% of Copenhagen’s workforce commute daily on bicycles, and only 27% drive cars. In that city bicycles can be rented for free.',
    '40% of all Amsterdam’s commutes are made on a bike.'
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
      alignment: Alignment.center,
      //color: Colors.white54,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 20),
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: textret(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget textret() {
    final _random = new Random();
    String dyk = "Did you know? " + didyk[_random.nextInt(didyk.length)];
    return Text(
      dyk,
      style: TextStyle(
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
