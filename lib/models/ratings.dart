class RatingsModel {
  final double rating;
  final String commentOwner;
  final String reviewText;
  const RatingsModel(
    this.rating,
    this.commentOwner,
    this.reviewText,
  ) : assert(rating != null && commentOwner != null && reviewText != null);
}
