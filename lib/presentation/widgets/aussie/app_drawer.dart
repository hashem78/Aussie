import 'dart:math' as math;

import 'package:aussie/aussie_imports.dart';

@immutable
class _DrawerItemModel extends Equatable {
  final String navPath;
  final String svgName;
  final String tTitle;
  final Color iconColor;

  const _DrawerItemModel({
    required this.navPath,
    required this.svgName,
    required this.tTitle,
    this.iconColor = Colors.black,
  });

  @override
  List<Object> get props => <Object>[navPath, svgName];
}

class _DrawerSection extends StatelessWidget {
  final List<_DrawerItemModel>? models;
  final IconData? sectionIcon;
  final String tSectionTitle;

  final Color? tilesColor;
  const _DrawerSection({
    this.models,
    this.sectionIcon,
    required this.tSectionTitle,
    this.tilesColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _DrawerSectionTitle(
          iconData: sectionIcon,
          title: getTranslation(context, tSectionTitle),
        ),
        ...models!
            .map(
              (_DrawerItemModel e) => _DrawerItem(e, color: tilesColor),
            )
            .toList(),
      ],
    );
  }
}

class AussieAppDrawer extends StatelessWidget {
  static const List<_DrawerItemModel> infoModels = <_DrawerItemModel>[
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
  static const List<_DrawerItemModel> miscModels = <_DrawerItemModel>[
    _DrawerItemModel(
      tTitle: AussieScreenData.settingsTitle,
      svgName: AussieScreenData.settingsSvgName,
      navPath: AussieScreenData.settingsNavPath,
      iconColor: Colors.grey,
    ),
  ];
  static const List<_DrawerSection> _sections = <_DrawerSection>[
    _DrawerSection(
      sectionIcon: Icons.info,
      tSectionTitle: 'infoSectionTitle',
      tilesColor: Colors.blue,
      models: infoModels,
    ),
    _DrawerSection(
      sectionIcon: Icons.miscellaneous_services,
      tSectionTitle: 'miscSectionTitle',
      tilesColor: Colors.blue,
      models: miscModels,
    ),
  ];
  static const List<_DrawerSection> _sectionsNoMisc = <_DrawerSection>[
    _DrawerSection(
      sectionIcon: Icons.info,
      tSectionTitle: 'infoSectionTitle',
      tilesColor: Colors.blue,
      models: infoModels,
    ),
  ];

  const AussieAppDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverToBoxAdapter(
              child: _DrawerHeader(),
            ),
            BlocBuilder<UserManagementCubit, UserManagementState>(
              builder: (BuildContext context, UserManagementState state) {
                if (state is UserMangementHasUserData) {
                  return buildSliverList(_sections);
                } else {
                  return buildSliverList(_sectionsNoMisc);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  SliverList buildSliverList(List<_DrawerSection> sections) {
    return SliverList(
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
        childCount: math.max(
          0,
          sections.length * 2 - 1,
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserManagementCubit, UserManagementState>(
      builder: (BuildContext context, UserManagementState state) {
        if (state is UserMangementHasUserData) {
          return Material(
            color: Theme.of(context).backgroundColor,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<UserProfileScreen>(
                    builder: (BuildContext context) {
                      return BlocProvider<UserManagementCubit>(
                        create: (BuildContext context) {
                          return UserManagementCubit()..getUserData();
                        },
                        child: const UserProfileScreen(
                          allowEventCreation: true,
                        ),
                      );
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CachedNetworkImage(
                        imageUrl: state.user.profilePictureLink!,
                        imageBuilder: (BuildContext context,
                            ImageProvider<Object> imageProvider) {
                          return Ink.image(image: imageProvider);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      state.user.username!,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 150.sp),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final _DrawerItemModel model;

  final Color? color;

  const _DrawerItem(
    this.model, {
    this.color = Colors.lightBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(model.navPath);
          },
          leading: SvgPicture.asset(
            'assets/images/${model.svgName}',
            height: 30,
            color: model.iconColor,
          ),
          title: Text(
            getTranslation(context, model.tTitle),
            style: TextStyle(fontSize: 80.sp),
          ),
        ),
      ],
    );
  }
}

class _DrawerSectionTitle extends StatelessWidget {
  final IconData? iconData;

  final String? title;
  const _DrawerSectionTitle({
    required this.iconData,
    required this.title,
  }) : assert(iconData != null && title != null);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 10,
          ),
          Icon(iconData, size: 140.sp),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 5,
            child: Text(
              title!,
              style: TextStyle(fontSize: 120.sp),
            ),
          ),
        ],
      ),
    );
  }
}
