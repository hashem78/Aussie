import 'package:aussie/aussie_imports.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: const PublicFeed(),
    );
  }
}
