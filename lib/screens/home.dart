import 'package:cvmakr/components/section-item.dart';
import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/data/experience.dart';
import 'package:cvmakr/screens/degrees/degrees.dart';
import 'package:cvmakr/screens/experiences/experiences.dart';
import 'package:cvmakr/screens/languages/languages.dart';
import 'package:cvmakr/screens/personal_informations.dart';
import 'package:cvmakr/screens/skills/skills.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const String id = 'home';

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "cv",
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                    ),
                    Text(
                      "Makr",
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SectionItem(
                        title: 'Informations personnelles',
                        iconName: Icons.person_outline,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PersonalInformations()),
                        ),
                      ),
                      SectionItem(
                        title: 'Expériences',
                        iconName: Icons.domain,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Experiences()),
                        ),
                      ),
                      SectionItem(
                        title: 'Formations',
                        iconName: Icons.school,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Degrees()),
                        ),
                      ),
                      SectionItem(
                        title: 'Compétences',
                        iconName: Icons.assignment,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Skills()),
                        ),
                      ),
                      SectionItem(
                        title: 'Langues',
                        iconName: Icons.language,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Languages()),
                        ),
                      ),
                      SectionItem(
                        title: 'Modèles de CV',
                        iconName: Icons.filter,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            //splashColor: Colors.white,
            //highlightColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0),
            ),
            elevation: 0,
            color: primaryColor,
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              "Je génère mon CV",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              data.experiences.add(Experience(
                  job: "un job",
                  company: "une company",
                  from: DateTime.now(),
                  to: DateTime.now(),
                  description: "une description de test"));
              data.save();
            },
          ),
        ),
        elevation: 0,
      ),
    );
  }
}
