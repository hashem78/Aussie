import 'dart:math' as math;

import 'package:aussie/models/usermanagement/user/user_model.dart';
import 'package:aussie/presentation/screens/profile/profile.dart';
import 'package:aussie/presentation/screens/screen_data.dart';

import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

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
              (e) => _DrawerItem(e, color: tilesColor),
            )
            .toList(),
      ],
    );
  }
}

class AussieAppDrawer extends StatelessWidget {
  const AussieAppDrawer();
  static const List<_DrawerItemModel> infoModels = [
    _DrawerItemModel(
      navPath: AussieScreenData.faunaNavPath,
      svgName: AussieScreenData.faunaSvgName,
      tTitle: AussieScreenData.faunaTitle,
      iconColor: Colors.brown,
    ),
    _DrawerItemModel(
      navPath: AussieScreenData.floraNavPath,
      svgName: AussieScreenData.floraSvgName,
      tTitle: AussieScreenData.floraTitle,
      iconColor: Color(0xFF1B5E20),
    ),
    _DrawerItemModel(
      navPath: AussieScreenData.weatherNavPath,
      svgName: AussieScreenData.weatherSvgName,
      tTitle: AussieScreenData.weatherTitle,
      iconColor: Colors.lightBlue,
    ),
    _DrawerItemModel(
      navPath: AussieScreenData.territoriesNavPath,
      svgName: AussieScreenData.territoriesSvgName,
      tTitle: AussieScreenData.territoriesTitle,
      iconColor: Colors.green,
    ),
    _DrawerItemModel(
      navPath: AussieScreenData.naturalParksNavPath,
      svgName: AussieScreenData.naturalParksSvgName,
      tTitle: AussieScreenData.naturalParksTitle,
      iconColor: Color(0xFF1B5E20),
    ),
  ];
  static const List<_DrawerItemModel> miscModels = [
    _DrawerItemModel(
      tTitle: AussieScreenData.settingsTitle,
      svgName: AussieScreenData.settingsSvgName,
      navPath: AussieScreenData.settingsNavPath,
      iconColor: Colors.grey,
    ),
  ];
  static const List<_DrawerSection> sections = [
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
    return SafeArea(
      child: Drawer(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: _DrawerHeader(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final int itemIndex = index ~/ 2;
                  if (index.isEven) {
                    return sections[itemIndex];
                  }
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
    return BlocBuilder<UserManagementCubit, UserManagementState>(
      builder: (context, state) {
        final AussieUser user =
            state is UserMangementHasUserData ? state.user : null;
        return Material(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: user != null
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) =>
                              UserManagementCubit()..getUserData(),
                          child: const UserProfileScreen(),
                        ),
                      ),
                    );
                  }
                : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: user != null
                        ? CachedNetworkImage(
                            imageUrl: user.profilePictureLink,
                            imageBuilder: (context, imageProvider) {
                              return Ink.image(image: imageProvider);
                            },
                          )
                        : Shimmer.fromColors(
                            baseColor: Colors.red,
                            highlightColor: Colors.yellow,
                            child: const ColoredBox(
                              color: Colors.green,
                            ),
                          ),
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                    user?.username ?? "Hi",
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontSize: 150.ssp),
                  ),
                )
              ],
            ),
          ),
        );
      },
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
              height: 25,
              color: model.iconColor,
            ),
            title: Text(
              getTranslation(context, model.tTitle),
              style: TextStyle(fontSize: 70.ssp),
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
          const SizedBox(
            width: 10,
          ),
          Icon(iconData, size: 80.ssp),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 5,
            child: Text(
              title,
              style: TextStyle(fontSize: 80.ssp),
            ),
          ),
        ],
      ),
    );
  }
}
