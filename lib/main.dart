import 'dart:convert';
import 'dart:math';

import 'package:aussie/constants.dart';
import 'package:aussie/localizations.dart';

import 'package:aussie/presentation/screens/misc/settings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/state/language/cubit/language_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:aussie/models/themes/themes.dart';
import 'package:aussie/presentation/screens/info/species/fauna.dart';
import 'package:aussie/presentation/screens/info/species/flora.dart';
import 'package:aussie/presentation/screens/info/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/info/teritories/teritories.dart';
import 'package:aussie/presentation/screens/info/weather/weather.dart';

import 'package:aussie/state/themes/cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var _perfs = await SharedPreferences.getInstance();
  Map<String, dynamic> themeMap;
  if (_perfs.containsKey("theme")) {
    final String themeString = _perfs.get("theme");
    themeMap = jsonDecode(themeString);
  } else {
    themeMap = ThemeModel.defaultThemeMap;
    _perfs.setString("theme", jsonEncode(themeMap));
  }
  Locale locale;
  if (_perfs.containsKey("lang")) {
    locale = Locale(_perfs.getString("lang"), '');
  } else {
    _perfs.setString("lang", "en");
    locale = Locale('en', '');
  }
  runApp(MyApp(themeMap, locale));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic> themeMap;
  final ThemeCubit _themeCubit;
  final LanguageCubit _languageCubit;
  final Locale locale;
  MyApp(this.themeMap, this.locale)
      : assert(themeMap != null && locale != null),
        _themeCubit = ThemeCubit(themeMap),
        _languageCubit = LanguageCubit(locale);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _themeCubit),
        BlocProvider.value(value: _languageCubit),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return Provider<AussieAppDrawer>(
                create: (context) => AussieAppDrawer(),
                child: MaterialApp(
                  locale: languageState.currentLocale,
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    AussieLocalizations.delegate,
                  ],
                  supportedLocales: [
                    const Locale('en', ''),
                    const Locale('ar', ''),
                  ],
                  localeResolutionCallback: (locale, supportedLocales) {
                    if (supportedLocales.contains(locale)) return locale;
                    return supportedLocales.first;
                  },
                  home: MainScreen(),
                  theme: ThemeData(
                    brightness: state.model.brightness,
                  ),
                  routes: routes,
                ),
              );
            },
          );
        },
      ),
    );
  }

  static final routes = {
    NaturalParksScreen.data.navPath: (BuildContext context) =>
        NaturalParksScreen(),
    WeatherScreen.data.navPath: (BuildContext context) => WeatherScreen(),
    TeritoriesScreen.data.navPath: (BuildContext context) => TeritoriesScreen(),
    FaunaScreen.data.navPath: (BuildContext context) => FaunaScreen(),
    FloraScreen.data.navPath: (BuildContext context) => FloraScreen(),
    SettingsScreen.navPath: (BuildContext context) => SettingsScreen(),
  };
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      drawer: getAppDrawer(context),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            primary: true,
            pinned: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            textTheme: Typography.material2018().black,
            centerTitle: true,
            title: Text(
              "Feed",
              style: TextStyle(fontSize: 60.sp, fontWeight: FontWeight.w400),
            ),
            elevation: 0,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                FeedCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeedCard extends StatelessWidget {
  const FeedCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AllCommentsScreen();
              },
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UpperHalf(),
            FeedCardComment(),
            FeedCardTextField(),
          ],
        ),
      ),
    );
  }
}

class AllCommentsScreen extends StatefulWidget {
  const AllCommentsScreen({
    Key key,
  }) : super(key: key);

  @override
  _AllCommentsScreenState createState() => _AllCommentsScreenState();
}

class _AllCommentsScreenState extends State<AllCommentsScreen> {
  PagingController pagingController;
  @override
  void initState() {
    super.initState();
    pagingController = PagingController(firstPageKey: 0);
    pagingController.appendLastPage([1, 1]);
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: .5.sh,
            flexibleSpace: FlexibleSpaceBar(
              background: buildImage(kurl),
            ),
          ),
          PagedSliverList(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (context, item, index) {
                return FeedCardComment();
              },
              noMoreItemsIndicatorBuilder: (context) {
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FeedCardTextField extends StatelessWidget {
  const FeedCardTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Leave a comment!",
          hintStyle: TextStyle(fontSize: 40.sp),
          isDense: true,
          contentPadding: EdgeInsets.only(bottom: 5),
        ),
      ),
    );
  }
}

class FeedCardComment extends StatefulWidget {
  const FeedCardComment({
    Key key,
  }) : super(key: key);

  @override
  _FeedCardCommentState createState() => _FeedCardCommentState();
}

class _FeedCardCommentState extends State<FeedCardComment>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController _controller;
  Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300 + Random().nextInt(100)),
    )..forward();
    _animation = Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SlideTransition(
      position: _animation,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        title: Text("Hashem"),
        subtitle: Text("Hello"),
        leading: Container(
          width: .1.sw,
          height: .1.sw,
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class UpperHalf extends StatelessWidget {
  const UpperHalf({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: .4.sw,
                  height: .4.sw,
                  child: buildImage("https://picsum.photos/seed/picsum/300"),
                ),
                Positioned(
                  bottom: 0,
                  child: Text("#sth"),
                ),
              ],
            ),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      width: .1.sw,
                      height: .1.sw,
                      child: buildImage("https://picsum.photos/100"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text("hi posted"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: .40.sw,
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                HeartButton(),
                SizedBox(width: .05.sw),
                ShareButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [Icon(Icons.share), SizedBox(width: .01.sw), Text("Share")],
      ),
    );
  }
}

class HeartButton extends StatelessWidget {
  const HeartButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [Icon(Icons.mood), SizedBox(width: .01.sw), Text("Like")],
      ),
    );
  }
}
