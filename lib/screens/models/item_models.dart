import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemModels extends StatelessWidget {
  final String id;

  ItemModels({this.id});

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);

    return Container(
      child: Align(
        child: GestureDetector(
          onTap: () => data.selectModel(id),
          child: Card(
            child: Stack(children: <Widget>[
              Image.network('http://192.168.1.13:3000/preview?id=$id'),
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
