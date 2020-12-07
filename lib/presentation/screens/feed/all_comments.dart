import 'package:aussie/constants.dart';
import 'package:aussie/presentation/screens/feed/widgets/comment.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
              title: Text("#Post title"),
            ),
          ),
          // TODO: post details
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
