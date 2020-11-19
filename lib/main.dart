import 'package:flutter/material.dart';
import 'package:flutter_app/phone_number_page.dart';
import 'package:flutter_app/step_progress_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
