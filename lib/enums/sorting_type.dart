enum SortingType {
  LATEST("latest", "최신순"),
  OLDEST("oldest", '오래된 순'),
  HiGHEST_RATING("highestRating", "평점 높은 순"),
  LOWEST_RATiNG("lowestRating", "평점 낮은 순");

  const SortingType(this.code, this.displayName);
  final String code;
  final String displayName;

  @override
  String toString() => displayName;

  factory SortingType.getByCode(String code) {
    return SortingType.values.firstWhere((value) => value.code == code,
        orElse: () => SortingType.LATEST);
  }
}