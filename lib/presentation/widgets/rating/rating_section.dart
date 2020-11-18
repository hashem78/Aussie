import 'package:aussie/models/ratings.dart';
import 'package:aussie/presentation/widgets/rating/rating_tile.dart';
import 'package:aussie/state/ratings/cubit/ratings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingSection extends StatelessWidget {
  final bool readOnly;
  final String id;
  final String title = "Reviews";
  final RatingsCubit cubit;
  RatingSection({
    Key key,
    @required this.id,
    this.readOnly = false,
  })  : assert(id != null),
        cubit = RatingsCubit(id);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Reviews",
                style: TextStyle(fontSize: 100.sp, fontWeight: FontWeight.w600),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RatingDetailsScreen(cubit),
                  ),
                );
              },
              child: Ink(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Read all reviews",
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Column(
        //   children: widget.models
        //       .map(
        //         (e) => RatingTile(
        //           model: e,
        //           readOnly: true,
        //           color: getRandomColor(),
        //         ),
        //       )
        //       .toList(),
        // ),
      ],
    );
  }
}

class RatingDetailsScreen extends StatefulWidget {
  final RatingsCubit cubit;
  const RatingDetailsScreen(this.cubit);
  @override
  _RatingDetailsScreenState createState() => _RatingDetailsScreenState();
}

class _RatingDetailsScreenState extends State<RatingDetailsScreen> {
  PagingController<int, RatingsModel> _controller =
      PagingController<int, RatingsModel>(firstPageKey: 0);
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  @override
  void initState() {
    super.initState();
    _controller.addPageRequestListener(
      (pageKey) {
        widget.cubit.fetch(pageKey, fetchAmount: 10);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldState,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _scaffoldState.currentState.showBottomSheet(
              (context) => WriteReviewSheet(widget.cubit),
            );
          },
          child: Icon(Icons.add, size: 100.sp),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              stretch: true,
              expandedHeight: .5.sh,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.fadeTitle,
                  StretchMode.zoomBackground,
                ],
              ),
              elevation: 0,
              title: Text("Ratings"),
              centerTitle: true,
            ),
            BlocListener<RatingsCubit, RatingsState>(
              cubit: widget.cubit,
              listener: (context, state) {
                if (state is RatingsDataChanged) {
                  final nextKey = _controller.nextPageKey + state.models.length;
                  _controller.appendPage(state.models, nextKey);
                } else if (state is RatingsEmpty) {
                  _controller.appendLastPage([]);
                }
              },
              child: buildPagedSliverList(),
            ),
          ],
        ),
      ),
    );
  }

  PagedSliverList<int, RatingsModel> buildPagedSliverList() {
    return PagedSliverList<int, RatingsModel>(
      pagingController: _controller,
      builderDelegate: PagedChildBuilderDelegate<RatingsModel>(
        itemBuilder: (context, model, index) {
          return RatingTile(
            model: model,
            readOnly: true,
            color: Colors.transparent,
          );
        },
        noMoreItemsIndicatorBuilder: (_) => Container(
          height: 50,
          child: Center(
            child: Text(
              "No more reviews to show",
            ),
          ),
        ),
      ),
    );
  }
}

class WriteReviewSheet extends StatefulWidget {
  final RatingsCubit cubit;

  const WriteReviewSheet(this.cubit);

  @override
  _WriteReviewSheetState createState() => _WriteReviewSheetState();
}

class _WriteReviewSheetState extends State<WriteReviewSheet> {
  final TextEditingController _nickName = TextEditingController();
  final TextEditingController _review = TextEditingController();
  @override
  void dispose() {
    _nickName.dispose();
    _review.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formState = GlobalKey();
  double _stars = 2.5;
  @override
  Widget build(BuildContext context) {
    return BlocListener<RatingsCubit, RatingsState>(
      cubit: widget.cubit,
      listener: (context, state) {
        if (state is RatingAdded) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Your review has been added!"),
            ),
          );
        }
      },
      child: SingleChildScrollView(
        child: Container(
          height: .65.sh,
          child: Form(
            key: _formState,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: .05.sh,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: _nickName,
                    validator: (text) {
                      if (text.isEmpty || text == null) {
                        return "This field can't be empty";
                      } else if (text.length <= 5) {
                        return "This field should be atleast 6 characters long";
                      }
                      return null;
                    },
                    maxLength: 15,
                    decoration: const InputDecoration(
                      focusColor: Colors.blue,
                      hintText: "Nickname",
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.zero),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: .05.sh),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: _review,
                    validator: (text) {
                      if (text.isEmpty || text == null) {
                        return "This field can't be empty";
                      } else if (text.length <= 5) {
                        return "This field nickname should be atleast 6 characters long";
                      }
                      return null;
                    },
                    maxLength: 256,
                    decoration: const InputDecoration(
                      hintText: "Something helpful...",
                      focusColor: Colors.blue,
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.zero),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: .05.sh),
                SmoothStarRating(
                  size: .15.sw,
                  color: Colors.amber,
                  rating: _stars,
                  onRated: (rating) {
                    _stars = rating;
                  },
                ),
                SizedBox(height: .05.sh),
                SizedBox.fromSize(
                  size: Size(.5.sw, .1.sh),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formState.currentState.validate()) {
                        await widget.cubit
                            .addRating(
                              RatingsModel(
                                  _stars, _nickName.text, _review.text),
                            )
                            .whenComplete(() => print("done"));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
