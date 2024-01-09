import 'package:json_annotation/json_annotation.dart';

part 'movie_rating_response.g.dart';

@JsonSerializable()
class MovieRatingResponse {
  @JsonKey(name: "averageRating")
  final double totalRating;
  final int countOneStar;
  final int countTwoStar;
  final int countThreeStar;
  final int countFourStar;
  final int countFiveStar;

  @JsonKey(name: "countStart")
  final int countStar;

  const MovieRatingResponse({
    this.totalRating = 0,
    this.countOneStar = 0,
    this.countTwoStar = 0,
    this.countThreeStar = 0,
    this.countFourStar = 0,
    this.countFiveStar = 0,
    this.countStar = 0,
  });

  double getPercentByPoint(int value) {
    if (countStar == 0) return 0;

    if (value == 1 && countOneStar != 0) {
      return countOneStar / countStar;
    }

    if (value == 2 && countTwoStar != 0) {
      return countTwoStar / countStar;
    }

    if (value == 3 && countThreeStar != 0) {
      return countThreeStar / countStar;
    }

    if (value == 4 && countFourStar != 0) {
      return countFourStar / countStar;
    }

    if (value == 5 && countFiveStar != 0) {
      return countFiveStar / countStar;
    }

    return 0;
  }

  factory MovieRatingResponse.fromJson(Map<String, dynamic> json) => _$MovieRatingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieRatingResponseToJson(this);
}
