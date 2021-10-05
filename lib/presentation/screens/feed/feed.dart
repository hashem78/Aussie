import 'package:aussie/aussie_imports.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocBuilder<UserManagementCubit, UserManagementState>(
        builder: (context, state) {
          return AussieScaffold(
            drawer: const AussieAppDrawer(),
            appBar: AppBar(
              centerTitle: true,
              title: AutoSizeText(
                getTranslation(context, "feedScreenTitle"),
                style: TextStyle(
                  fontSize: 100.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              elevation: 0,
            ),
            body: state is UserMangementHasUserData
                ? Provider.value(
                    value: state.user,
                    child: BlocProvider(
                      create: (context) => EventManagementCubit(),
                      child: const PublicEventsTab(),
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

