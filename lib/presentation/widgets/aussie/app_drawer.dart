import 'dart:math' as math;

import 'package:aussie/aussie_imports.dart';

@immutable
class _DrawerItemModel extends Equatable {
  final String tTitle;
  final Color iconColor;
  final IconData iconData;
  final String navPath;

  const _DrawerItemModel({
    required this.tTitle,
    required this.iconData,
    this.iconColor = Colors.black,
    required this.navPath,
  });

  @override
  List<Object> get props => <Object>[tTitle, iconColor, navPath];
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
  static const List<_DrawerItemModel> miscModels = <_DrawerItemModel>[
    _DrawerItemModel(
      tTitle: ScreenData.settingsTitle,
      iconColor: Colors.grey,
      iconData: Icons.settings,
      navPath: ScreenData.settingsNavPath,
    ),
  ];
  static const List<_DrawerSection> _sections = <_DrawerSection>[
    _DrawerSection(
      sectionIcon: Icons.miscellaneous_services,
      tSectionTitle: 'miscSectionTitle',
      tilesColor: Colors.blue,
      models: miscModels,
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
            BlocBuilder<UMCubit, UMCState>(
              builder: (BuildContext context, UMCState state) {
                if (state is UMCHasUserData) {
                  return buildSliverList(_sections);
                }
                return Container();
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
    return BlocBuilder<UMCubit, UMCState>(
      builder: (BuildContext context, UMCState state) {
        if (state is UMCHasUserData) {
          return Material(
            color: Theme.of(context).backgroundColor,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<UserProfileScreen>(
                    builder: (BuildContext context) {
                      return MultiBlocProvider(
                        providers: <BlocProvider<Object?>>[
                          BlocProvider<UMCubit>(
                            create: (BuildContext context) {
                              return UMCubit()..getUserData();
                            },
                          ),
                          BlocProvider<FollowersCubit>(
                            create: (BuildContext context) {
                              return FollowersCubit();
                            },
                          ),
                        ],
                        child: const UserProfileScreen(),
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
                        imageUrl: state.user.profilePictureLink,
                        imageBuilder: (BuildContext context,
                            ImageProvider<Object> imageProvider) {
                          return Ink.image(image: imageProvider);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      state.user.username,
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
          leading: Icon(model.iconData),
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
