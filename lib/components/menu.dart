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
          child: Text("Editer"),
          value: menu.edit,
        ),
        PopupMenuItem(
          child: Text("Supprimer"),
          value: menu.remove,
        )
      ],
    );
  }
}
