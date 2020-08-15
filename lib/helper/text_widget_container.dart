import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class TextWidgetContainer extends StatefulWidget {
  @override
  _TextWidgetContainerState createState() => _TextWidgetContainerState();
}

class _TextWidgetContainerState extends State<TextWidgetContainer> {

  TextEditingController textEditingController = new TextEditingController();
  String text = "";
  bool showTextField = true;
  Color textColor = Colors.red;
  double textFontSize = 25;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          showTextField == true ? Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            child: TextField(
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: "type here...",
                suffix: IconButton(
                  icon: Icon(Icons.sort, color: Colors.red,),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Choose Custom Fields"),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Choose Text Colour",
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ColorPicker(
                                  pickerColor: Color(0xff443a49),
                                  onColorChanged: (Color color) {
                                    setState(() {
                                      textColor = color;
                                    });
                                  },
                                  showLabel: true,
                                  pickerAreaHeightPercent: 0.8,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Choose Text Size",
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          textFontSize = textFontSize + 3;
                                        });
                                        Toast.show("Font Size : ${textFontSize.toInt()}", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                                      },
                                      icon: Icon(FontAwesomeIcons.plus),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          textFontSize = textFontSize - 3;
                                        });
                                        Toast.show("Font Size : ${textFontSize.toInt()}", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                                      },
                                      icon: Icon(FontAwesomeIcons.minus),
                                    ),
                                  ],
                                ),
//                                Text(
//                                  "Memespam",
//                                  style: TextStyle(
//                                    color: Colors.white,
//                                    fontSize: textFontSize.toDouble(),
//                                  ),
//                                ),
                                Row(
                                  children: <Widget>[
                                    FlatButton(onPressed: () {
                                      Navigator.pop(context);
                                    }, child: Text("OK")),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FlatButton(onPressed: () {
                                      Navigator.pop(context);
                                    }, child: Text("Cancel")),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                    );
                  },
                ),
//                suffixIcon: Icon(Icons.sort, color: Colors.red,),
//                suffix: FlatButton(
//                  onPressed: () {
//                    showDialog(
//                      context: context,
//                      builder: (context) => AlertDialog(
//                        title: Text("Choose custom fields"),
//                        actions: <Widget>[
//                          SingleChildScrollView(
//                            child: Column(
//                              mainAxisSize: MainAxisSize.min,
//                              children: <Widget>[
//                                Center(
//                                  child: Text(
//                                    "Choose Colour",
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ],
//                      )
//                    );
//                  },
//                ),
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
              color: textColor,
              fontSize: textFontSize.toDouble(),
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
