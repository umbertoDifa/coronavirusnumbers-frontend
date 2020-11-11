import 'package:corona_virus/models/state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 6.0, 18.0, 6.0),
      child: TextField(
        onChanged: (value) {
          Provider.of<StateModel>(context, listen: false).searchString = value;
        },
        style: Theme.of(context).textTheme.headline4,
        controller: editingController,
        decoration: InputDecoration(
          labelText: "Search",
          labelStyle: Theme.of(context).textTheme.headline4,
          hintStyle: Theme.of(context).textTheme.headline4,
          fillColor: Theme.of(context).textTheme.headline4.color,
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).iconTheme.color,
            size: Theme.of(context).iconTheme.size,
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).textTheme.headline4.color,
                  width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).textTheme.headline4.color,
                  width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
        ),
      ),
    );
  }
}
