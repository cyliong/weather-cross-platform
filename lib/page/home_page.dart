import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Icon _searchIcon = Icon(Icons.search);
  static const Icon _cancelIcon = Icon(Icons.cancel);

  Icon _activeIcon;
  Widget _titleBar;

  @override
  void initState() {
    super.initState();
    _activeIcon = _searchIcon;
    _titleBar = Text(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleBar,
        actions: [
          IconButton(
            icon: _activeIcon,
            onPressed: () {
              setState(() {
                if (_activeIcon.icon == Icons.search) {
                  _activeIcon = _cancelIcon;
                  _titleBar = _buildSearchBar();
                } else {
                  _activeIcon = _searchIcon;
                  _titleBar = Text(widget.title);
                }
              });
            },
          )
        ],
      ),
      body: const Center(
        child: Text("No weather data"),
      ),
    );
  }

  TextField _buildSearchBar() {
    return TextField(
      autofocus: true,
      cursorColor: Colors.lightBlueAccent,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Search a location',
      ),
      textInputAction: TextInputAction.search,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      onSubmitted: (String text) {},
    );
  }
}
