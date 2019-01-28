import 'package:flutter/material.dart';
import '../../config/application.dart';
import '../../config/routes.dart';

//Based on https://medium.com/@agungsurya/create-a-simple-animated-floatingactionbutton-in-flutter-2d24f37cfbcc

class CollectionsPageFab extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  CollectionsPageFab({this.onPressed, this.tooltip, this.icon});

  @override
  _CollectionsPageFabState createState() => _CollectionsPageFabState();
}

class _CollectionsPageFabState extends State<CollectionsPageFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.orange,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget addCollection() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'addCollection',
        onPressed: () {
          animate();
          Application.router.navigateTo(context, Routes.createCollectionRoute);
        },
        tooltip: 'Adicionar coleção',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget addCollectionItem() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'addCollectionItem',
        onPressed: null,
        tooltip: 'Adicionar item',
        child: Icon(Icons.camera_enhance),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'collectionsMenu',
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Menu',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: addCollection(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: addCollectionItem(),
        ),
        toggle(),
      ],
    );
  }
}
