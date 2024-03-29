import 'package:aussie/aussie_imports.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocBuilder<UMCubit, UMCState>(
        builder: (BuildContext context, UMCState state) {
          return AussieScaffold(
            drawer: const AussieAppDrawer(),
            appBar: AppBar(
              centerTitle: true,
              title: AutoSizeText(
                getTranslation(context, 'feedScreenTitle'),
                style: TextStyle(
                  fontSize: 100.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              elevation: 0,
            ),
            body: state is UMCHasUserData
                ? Provider<AussieUser>.value(
                    value: state.user,
                    child: BlocProvider<EMCubit>(
                      create: (BuildContext context) => EMCubit(),
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
