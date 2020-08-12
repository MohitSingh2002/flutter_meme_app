import 'package:flutter/material.dart';

class EditMemePage extends StatefulWidget {

  final String memeUrl;
  final String memeName;

  const EditMemePage({Key key, this.memeUrl, this.memeName}) : super(key: key);

  @override
  _EditMemePageState createState() => _EditMemePageState();
}

class _EditMemePageState extends State<EditMemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        shadowColor: Colors.white,
        title: Text(widget.memeName),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save_alt),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*0.7,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.memeUrl),
                ),
              ),
            ),
            //The below code is just for testing of drag widget.
            //InteractiveViewer is a new widget in latest version of Flutter i.e. 1.20.0.
            InteractiveViewer(
              boundaryMargin: EdgeInsets.symmetric(
                vertical: double.infinity,
                horizontal: double.infinity,
              ),
              child: Text("Hello",style: TextStyle(color: Colors.yellow),),
            ),
          ],
        ),
      ),
      bottomNavigationBar: RaisedButton(
        onPressed: () {},
        splashColor: Colors.blue,
        color: Colors.deepPurple,
        child: Text("Add Text"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
