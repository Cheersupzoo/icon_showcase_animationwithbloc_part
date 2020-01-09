import 'package:flutter/material.dart';
import 'package:icon_showcase_animationwithbloc_part/color_palette.dart';
import 'package:icon_showcase_animationwithbloc_part/fade_page_route.dart';
import 'package:icon_showcase_animationwithbloc_part/icon_data.dart'
    as ModelIcondata;
import 'package:icon_showcase_animationwithbloc_part/detail_page.dart';
import 'package:icon_showcase_animationwithbloc_part/title_hero_flight.dart';
import 'package:icon_showcase_animationwithbloc_part/view_state.dart';
import 'package:icon_showcase_animationwithbloc_part/bloc/iconlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => IconlistBloc()..dispatch(LoadDefaultIcon()),
      child: MaterialApp(
        title: 'Icon Showcase',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Icon Showcase'),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _animationController;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _initAnimationController();
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
    final iconListBloc = BlocProvider.of<IconlistBloc>(context);
    return BlocBuilder(
        bloc: iconListBloc,
        builder: (BuildContext context, IconlistState state) {
          if (state is IconListLoading) {
            return Container(); // return a Container when app is loading data
          } else if (state is IconListLoaded) {
            final iconList = state.iconList;

            return Scaffold(
              backgroundColor: ColorPalette.grey90,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Text(
                  widget.title,
                  style: TextStyle(color: ColorPalette.grey10),
                ),
                leading: IconButton(
                  icon: Hero(
                    tag: 'menuarrow',
                    child: AnimatedIcon(
                      icon: AnimatedIcons.menu_arrow,
                      progress: _animationController,
                      color: ColorPalette.grey10,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              body: AnimatedList(
                key: _listKey,
                initialItemCount: iconList.length,
                itemBuilder: (context, index, animation) =>
                    buildCard(iconList[index], animation),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: 'add',
                      child: Icon(Icons.add),
                      onPressed: () {
                        iconListBloc.dispatch(AddIcon());
                        _listKey.currentState.insertItem(iconList.length);
                      },
                      backgroundColor: Colors.green,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    FloatingActionButton(
                      heroTag: 'remove',
                      child: Icon(Icons.remove),
                      onPressed: () {
                        if (iconList.length != 0) {
                          final removeicon = iconList.last;
                          final removeiconIndex = iconList.length - 1;
                          iconListBloc.dispatch(RemoveIcon(removeiconIndex));

                          _listKey.currentState.removeItem(
                              removeiconIndex,
                              (index, animation) =>
                                  buildCard(removeicon, animation));
                        }
                      },
                      backgroundColor: Colors.redAccent,
                    )
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget buildCard(ModelIcondata.IconModel iconData, Animation animation) {
    return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: SizeTransition(
          sizeFactor: animation,
          child: InkWell(
              onTap: () async {
                _animationController.forward(from: 0.0);

                bool returnVal = await Navigator.of(context).push(FadePageRoute(
                    builder: (context) => DetailPage(
                          iconData: iconData,
                        )));
                if (returnVal) {
                  _animationController.reverse(from: 1.0);
                }
              },
              child: Stack(children: <Widget>[
                Hero(
                  tag: iconData.cardkey,
                  child: Card(
                      color: ColorPalette.grey10,
                      margin: EdgeInsets.all(10),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: ListTile(
                          leading: Icon(
                            iconData.icon,
                            size: 45.0,
                            color: Colors.transparent,
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: ListTile(
                      title: Hero(
                        tag: iconData.titlekey,
                        flightShuttleBuilder: (
                          BuildContext flightContext,
                          Animation<double> animation,
                          HeroFlightDirection flightDirection,
                          BuildContext fromHeroContext,
                          BuildContext toHeroContext,
                        ) {
                          return DestinationTitle(
                            viewState:
                                flightDirection == HeroFlightDirection.push
                                    ? ViewState.enlarge
                                    : ViewState.shrink,
                            smallFontSize: 20.0,
                            largeFontSize: 60.0,
                            title: iconData.title,
                            isOverflow: true,
                          );
                        },
                        child: DestinationTitle(
                          title: iconData.title,
                          color: Colors.black87,
                          viewState: ViewState.shrunk,
                          smallFontSize: 20.0,
                          largeFontSize: 60.0,
                        ),
                      ),
                      leading: Hero(
                        tag: iconData.iconkey,
                        child: Icon(
                          iconData.icon,
                          size: 45.0,
                          color: ColorPalette.grey60,
                        ),
                      )),
                ),
              ])),
        ));
  }
}
