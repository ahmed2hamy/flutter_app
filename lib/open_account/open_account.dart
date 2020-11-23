import 'package:flutter/material.dart';
import 'package:flutter_app/open_account/phone_number_page.dart';
import 'package:flutter_app/open_account/widgets/step_progress_view.dart';

class OpenAccount extends StatefulWidget {

  @override
  _OpenAccountState createState() => _OpenAccountState();
}

class _OpenAccountState extends State<OpenAccount> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  bool _canNavigate = true;
  List<Widget> pages = [
    PhoneNumberPage(),
    Container(color: Colors.amberAccent),
    Container(color: Colors.cyanAccent),
    Container(color: Colors.purpleAccent),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentStep = _pageController.page.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New to UBA"),
      ),
      body: Column(
        children: [
          StepProgressView(
            currentStep: _currentStep,
            stepsCount: pages.length,
            width: MediaQuery.of(context).size.width,
            activeColor: Colors.red,
          ),
          Expanded(
            child: PageView(
              // physics: NeverScrollableScrollPhysics(),
              children: pages,
              controller: _pageController,
            ),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                _canNavigate
                    ? _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease)
                    : null;
              });
            },
            child: Text("Next"),
          ),
          SizedBox(height: 10),
          OutlineButton(
            onPressed: () {},
            child: Text("Cancel"),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}