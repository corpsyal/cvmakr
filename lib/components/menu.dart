import 'package:cvmakr/data/data.dart';
import 'package:flutter/material.dart';

enum menu { edit, remove }

class Menu extends StatelessWidget {
  Function onSelect;

  Menu({this.onSelect});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 2,
      onSelected: onSelect,
      child: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<menu>>[
        PopupMenuItem(
          child: Text(Data.translate("edit")),
          value: menu.edit,
        ),
        PopupMenuItem(
          child: Text(Data.translate("delete")),
          value: menu.remove,
        )
      ],
    );
  }
}
