import 'package:icon_showcase_animationwithbloc_part/color_palette.dart';
import 'package:icon_showcase_animationwithbloc_part/icon_data.dart';
import 'package:flutter/material.dart';
import 'package:icon_showcase_animationwithbloc_part/title_hero_flight.dart';

import 'view_state.dart';

class DetailPage extends StatefulWidget {
  final IconModel iconData;

  DetailPage({
    Key key,
    @required this.iconData,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initAnimationController();
    _animationController.forward();
  }

  void _initAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(true);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: ColorPalette.grey90,
        body: SafeArea(
          child: Stack(children: <Widget>[
            Hero(
              tag: widget.iconData.cardkey,
              child: Card(
                  margin: EdgeInsets.all(10),
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Stack(children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 500,
                        child: SizedBox()),
                  ])),
            ),
            Hero(
              tag: widget.iconData.iconkey,
              child: Card(
                  margin: EdgeInsets.all(10),
                  clipBehavior: Clip.antiAlias,
                  elevation: 0.0,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Stack(children: <Widget>[
                    Positioned.fill(
                        bottom: -90,
                        right: -90,
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              widget.iconData.icon,
                              size: 400,
                              color: ColorPalette.grey30,
                            ))),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 500,
                        child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, top: 20.0),
                            child: SizedBox())),
                  ])),
            ),
            Card(
                margin: EdgeInsets.all(10),
                clipBehavior: Clip.antiAlias,
                elevation: 0.0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                child: Stack(children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop(true);
                                return Future.value(false);
                              },
                              child: Hero(
                                tag: 'menuarrow',
                                child: AnimatedIcon(
                                  icon: AnimatedIcons.menu_arrow,
                                  progress: _animationController,
                                ),
                              ),
                            ),
                            Hero(
                              tag: widget.iconData.titlekey,
                              flightShuttleBuilder: (
                                BuildContext flightContext,
                                Animation<double> animation,
                                HeroFlightDirection flightDirection,
                                BuildContext fromHeroContext,
                                BuildContext toHeroContext,
                              ) {
                                return DestinationTitle(
                                  viewState: flightDirection ==
                                          HeroFlightDirection.push
                                      ? ViewState.enlarge
                                      : ViewState.shrink,
                                  smallFontSize: 20.0,
                                  largeFontSize: 60.0,
                                  title: widget.iconData.title,
                                  isOverflow: true,
                                );
                              },
                              child: DestinationTitle(
                                title: widget.iconData.title,
                                color: Colors.black87,
                                viewState: ViewState.enlarged,
                                smallFontSize: 20.0,
                                largeFontSize: 60.0,
                              ),
                            ),
                          ],
                        ),
                      )),
                ])),
          ]),
        ),
      ),
    );
  }
}
