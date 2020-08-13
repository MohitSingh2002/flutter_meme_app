import 'package:flutter/material.dart';
import 'package:meme_app/helper/edit_meme_page_helper.dart';

class EditMemePage extends StatefulWidget {

  final String memeUrl;
  final String memeName;

  EditMemePage({this.memeUrl, this.memeName});

  @override
  _EditMemePageState createState() => _EditMemePageState();
}

class _EditMemePageState extends State<EditMemePage> {

  List<EditMemePageHelper> list = List<EditMemePageHelper>();

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
        child: Stack(
//          mainAxisSize: MainAxisSize.min,
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
//            InteractiveViewer(
//              boundaryMargin: EdgeInsets.symmetric(
//                vertical: double.infinity,
//                horizontal: double.infinity,
//              ),
//              child: Text("Hello",style: TextStyle(color: Colors.yellow),),
//            ),
            getList(),
          ],
        ),
      ),
      bottomNavigationBar: RaisedButton(
        onPressed: () {
          EditMemePageHelper editMemePageHelper = new EditMemePageHelper(text: "Singh", color: Colors.yellow);
          list.add(editMemePageHelper);
          print(list);
          getList();
        },
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

  Widget getList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0,),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return InteractiveViewer(child: Text(list.elementAt(index).text, style: TextStyle(color: list.elementAt(index).color, fontSize: 30,),),
        boundaryMargin: EdgeInsets.symmetric(
          vertical: double.infinity,
          horizontal: double.infinity,
        ),);
      },
    );
  }

}
