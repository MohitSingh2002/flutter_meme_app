import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:meme_app/models/images_helper.dart';
import 'package:meme_app/models/meme_service.dart';
import 'package:meme_app/pages/edit_meme_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  MemeService memeService = MemeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        shadowColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Meme App",
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: memeService.getData(),
          builder: (_, AsyncSnapshot<List<ImagesHelper>> snapshot) {
            if(snapshot.hasData) {
              return StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return EditMemePage(
                            memeUrl: snapshot.data[index].url,
                            memeName: snapshot.data[index].name,
                          );
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: Colors.white54,
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data[index].url),
                                ),
                              ),
                            ),
                            Text(snapshot.data[index].name),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (int index) => new StaggeredTile.count(2, 2),
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 3.0,
              );
            } else {
              return Center(
                child: SpinKitThreeBounce(
                  color: Colors.white,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
