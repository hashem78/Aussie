import 'package:aussie/models/ratings.dart';
import 'package:aussie/presentation/widgets/rating/rating_tile.dart';
import 'package:aussie/state/ratings/cubit/ratings_cubit.dart';
import 'package:aussie/util/functions.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingSection extends StatefulWidget {
  final bool readOnly;
  final String id;
  final String titleImageUrl;
  final Color ratingsBackgroundColor;

  const RatingSection({
    Key key,
    @required this.id,
    this.readOnly = false,
    @required this.titleImageUrl,
    @required this.ratingsBackgroundColor,
  }) : assert(id != null && titleImageUrl != null);

  @override
  _RatingSectionState createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  final String title = "Reviews";
  RatingsCubit cubit;
  bool rebuildRatings = true;
  @override
  void initState() {
    super.initState();
    cubit = RatingsCubit(widget.id);
    cubit.getSpecificAmount(3);
  }

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
                    builder: (_) => RatingDetailsScreen(
                      cubit,
                      widget.titleImageUrl,
                      widget.ratingsBackgroundColor,
                    ),
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
        BlocBuilder<RatingsCubit, RatingsState>(
          cubit: cubit,
          buildWhen: (_, __) {
            if (rebuildRatings == true) {
              rebuildRatings = false;
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if (state is RatingsDataChanged) {
              if (state.models.length != 0) {
                return Column(
                  children: state.models
                      .map(
                        (e) => RatingTile(
                          model: e,
                          color: getRandomColor(),
                        ),
                      )
                      .toList(),
                );
              }
              return Text("There are no reviews to show");
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}

class RatingDetailsScreen extends StatefulWidget {
  final RatingsCubit cubit;
  final String titleImageUrl;
  final Color backgroundColor;
  const RatingDetailsScreen(
      this.cubit, this.titleImageUrl, this.backgroundColor);
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
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
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              stretch: true,
              expandedHeight: .8.sh,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.fadeTitle,
                  StretchMode.zoomBackground,
                ],
                background: buildImage(widget.titleImageUrl),
                title: Text("Ratings"),
                centerTitle: true,
              ),
              elevation: 0,
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
          Scaffold.of(context).showSnackBar(
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
                        await widget.cubit.addRating(
                          RatingsModel(_stars, _nickName.text, _review.text),
                        );
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
