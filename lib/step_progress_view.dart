import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepProgressView extends StatelessWidget {
  // final int _curStep;
  // final List<IconData> _icons;
  final int _stepsCount;
  final int _currentStep;
  final Color _activeColor;
  final Color _inactiveColor = Colors.grey[100];
  final List<String> _titles;
  final double _width;
  final double lineWidth = 4.0;

  StepProgressView({
    Key key,
    // @required int curStep,
    // @required List<IconData> icons,
    @required int currentStep,
    @required int stepsCount,
    @required Color activeColor,
    List<String> titles,
    double width,
  })  :
        // _curStep = curStep,
        // _icons = icons,
        _currentStep = currentStep,
        _stepsCount = stepsCount,
        _activeColor = activeColor,
        _titles = titles,
        _width = width,
        // assert(curStep > 0 == true && curStep <= icons.length),
        assert(currentStep >= 0 == true && currentStep < stepsCount),
        assert(width > 0),
        super(key: key);

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: 32.0,
          left: 24.0,
          right: 24.0,
        ),
        width: _width ?? MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Row(
              children: _stepsView(),
            ),
            SizedBox(
              height: 10,
            ),
            if (_titles != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _titleViews(),
              ),
          ],
        ));
  }

  List<Widget> _titleViews() {
    var list = <Widget>[];
    _titles.asMap().forEach((i, text) {
      list.add(Text(text, style: TextStyle(color: _activeColor)));
    });
    return list;
  }

  List<Widget> _stepsView() {
    List<Widget> list = [];
    for (int i = 0; i < _stepsCount; i++) {
      bool _stepDone = _currentStep > i;

      var circleColor =
          (i == 0 || _currentStep > i) ? _activeColor : _inactiveColor;

      var lineColor = _currentStep > i ? _activeColor : _inactiveColor;

      var numberColor =
          (i == 0 || _currentStep > i) ? _inactiveColor : _activeColor;

      list.add(
        //dot with number view
        Container(
          width: 30.0,
          height: 30.0,
          padding: EdgeInsets.all(0),
          child: Center(
            child: _stepDone
                ? Icon(
                    Icons.check,
                    color: _inactiveColor,
                    size: 15.0,
                  )
                : Text(
                    "${i + 1}",
                    style: TextStyle(color: numberColor, fontSize: 15.0),
                  ),
          ),
          decoration: BoxDecoration(
            color: circleColor,
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            border: Border.all(
              color: _activeColor,
              width: 2.0,
            ),
          ),
        ),
      );

      //line between icons
      if (i != _stepsCount - 1) {
        list.add(Expanded(
            child: Container(
          height: lineWidth,
          color: lineColor,
        )));
      }
    }
    return list;
  }

// List<Widget> _iconViews() {
//   var list = <Widget>[];
//   _icons.asMap().forEach((i, icon) {
//     //colors according to state
//     var circleColor =
//         (i == 0 || _curStep > i + 1) ? _activeColor : _inactiveColor;
//
//     var lineColor = _curStep > i + 1 ? _activeColor : _inactiveColor;
//
//     var iconColor =
//         (i == 0 || _curStep > i + 1) ? _inactiveColor : _activeColor;
//
//     list.add(
//       //dot with icon view
//       Container(
//         width: 30.0,
//         height: 30.0,
//         padding: EdgeInsets.all(0),
//         child: Icon(
//           icon,
//           color: iconColor,
//           size: 15.0,
//         ),
//         decoration: BoxDecoration(
//           color: circleColor,
//           borderRadius: BorderRadius.all(Radius.circular(25.0)),
//           border: Border.all(
//             color: _activeColor,
//             width: 2.0,
//           ),
//         ),
//       ),
//     );
//
//     //line between icons
//     if (i != _icons.length - 1) {
//       list.add(Expanded(
//           child: Container(
//         height: lineWidth,
//         color: lineColor,
//       )));
//     }
//   });
//
//   return list;
// }
}
