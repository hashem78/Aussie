import 'package:aussie/models/usermanagement/user/user.dart';
import 'package:aussie/presentation/screens/info/species/fauna.dart';
import 'package:aussie/presentation/screens/info/species/flora.dart';
import 'package:aussie/presentation/screens/info/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/info/teritories/teritories.dart';
import 'package:aussie/presentation/screens/info/weather/weather.dart';
import 'package:aussie/presentation/screens/misc/settings.dart';
import 'package:aussie/presentation/screens/profile/profile_screen.dart';
import 'package:aussie/presentation/widgets/aussie/inked_image.dart';

import 'package:aussie/util/functions.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

@immutable
class _DrawerItemModel extends Equatable {
  final String navPath;
  final String svgName;
  final String tTitle;
  final Color iconColor;

  const _DrawerItemModel({
    @required this.navPath,
    @required this.svgName,
    @required this.tTitle,
    this.iconColor = Colors.black,
  }) : assert(
          navPath != null && svgName != null && tTitle != null,
        );

  @override
  List<Object> get props => [navPath, svgName];
}

class _DrawerSection extends StatelessWidget {
  final List<_DrawerItemModel> models;
  final IconData sectionIcon;
  final String tSectionTitle;

  final Color tilesColor;
  const _DrawerSection({
    this.models,
    this.sectionIcon,
    this.tSectionTitle,
    this.tilesColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DrawerSectionTitle(
          iconData: sectionIcon,
          title: getTranslation(context, tSectionTitle),
        ),
        ...models
            .map(
              (e) => _DrawerItem(
                e,
                color: tilesColor,
              ),
            )
            .toList(),
      ],
    );
  }
}

class AussieAppDrawer extends StatelessWidget {
  static get infoModels => [
        _DrawerItemModel(
          navPath: FaunaScreen.data.navPath,
          svgName: FaunaScreen.data.svgName,
          tTitle: FaunaScreen.data.tTitle,
          iconColor: Colors.brown,
        ),
        _DrawerItemModel(
          navPath: FloraScreen.data.navPath,
          svgName: FloraScreen.data.svgName,
          tTitle: FloraScreen.data.tTitle,
          iconColor: Colors.green.shade900,
        ),
        _DrawerItemModel(
          navPath: WeatherScreen.data.navPath,
          svgName: WeatherScreen.data.svgName,
          tTitle: WeatherScreen.data.tTitle,
          iconColor: Colors.lightBlue,
        ),
        _DrawerItemModel(
          navPath: TeritoriesScreen.data.navPath,
          svgName: TeritoriesScreen.data.svgName,
          tTitle: TeritoriesScreen.data.tTitle,
          iconColor: Colors.green,
        ),
        _DrawerItemModel(
          navPath: NaturalParksScreen.data.navPath,
          svgName: NaturalParksScreen.data.svgName,
          tTitle: NaturalParksScreen.data.tTitle,
          iconColor: Colors.green.shade900,
        ),
      ];
  static get miscModels => [
        _DrawerItemModel(
          tTitle: SettingsScreen.tTitle,
          svgName: SettingsScreen.svgName,
          navPath: SettingsScreen.navPath,
          iconColor: Colors.grey,
        ),
      ];
  static get sections => [
        _DrawerSection(
          sectionIcon: Icons.info,
          tSectionTitle: "infoSectionTitle",
          tilesColor: Colors.blue,
          models: infoModels,
        ),
        _DrawerSection(
          sectionIcon: Icons.miscellaneous_services,
          tSectionTitle: "miscSectionTitle",
          tilesColor: Colors.blue,
          models: miscModels,
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _DrawerHeader(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final int itemIndex = index ~/ 2;
                if (index.isEven) {
                  return sections[itemIndex];
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                );
              },
              childCount: math.max(0, sections.length * 2 - 1),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AussieUser user = getCurrentUser(context);
    return SizedBox(
      height: .2.sh,
      child: Material(
        color: Theme.of(context).backgroundColor,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UserProfileScreen(),
              ),
            );
          },
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkedImage(user.profilePictureLink),
                ),
              ),
              Expanded(
                child: Text(
                  user.username,
                  style: Theme.of(context).textTheme.headline5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final _DrawerItemModel model;

  final Color color;

  const _DrawerItem(
    this.model, {
    this.color = Colors.lightBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5),
      child: Stack(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(model.navPath);
            },
            leading: SvgPicture.asset(
              "assets/images/${model.svgName}",
              height: 60.sp,
              color: model.iconColor,
            ),
            title: Text(
              getTranslation(context, model.tTitle),
              style: TextStyle(fontSize: 50.sp),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerSectionTitle extends StatelessWidget {
  final IconData iconData;

  final String title;
  const _DrawerSectionTitle({
    @required this.iconData,
    @required this.title,
  }) : assert(iconData != null && title != null);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: Icon(iconData, size: 70.sp),
          ),
          Expanded(
            flex: 5,
            child: Text(
              title,
              style: TextStyle(fontSize: 70.sp),
            ),
          ),
        ],
      ),
    );
  }
}
