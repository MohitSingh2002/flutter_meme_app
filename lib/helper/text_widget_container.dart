import 'package:flutter/material.dart';

class TextWidgetContainer extends StatefulWidget {
  @override
  _TextWidgetContainerState createState() => _TextWidgetContainerState();
}

class _TextWidgetContainerState extends State<TextWidgetContainer> {

  TextEditingController textEditingController = new TextEditingController();
  String text = "";
  bool showTextField = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          showTextField == true ? Container(
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "type here...",
              ),
              controller: textEditingController,
              onSubmitted: (val) {
                setState(() {
                  text = textEditingController.text;
                  showTextField = false;
                });
              },
            ),
          ) : Container(),
          Text(
            text,
            style: TextStyle(
              color: Colors.red,
              fontSize: 30,
            ),
          ),
//          Checkbox(value: value, onChanged: (val) {
//            setState(() {
//              value = !value;
//            });
//          }),
        ],
      ),
    );
  }
}
