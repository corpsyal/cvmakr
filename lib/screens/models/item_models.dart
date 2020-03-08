import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemModels extends StatelessWidget {
  final String id;
  final String link;

  ItemModels({this.id, this.link});

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);

    return Container(
      child: Align(
        child: GestureDetector(
          onTap: () => data.selectModel(id),
          child: Card(
            child: Stack(children: <Widget>[
              Image.network(link),
              data.model == id
                  ? Positioned(
                      child: CircleAvatar(
                        backgroundColor: primaryColor,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      bottom: 10,
                      right: 10,
                    )
                  : Text("")
            ]),
          ),
        ),
      ),
    );
  }
}
