enum ListSortingButtonType {
  LATEST("latest", "최신순"),
  OLDEST("oldest", '오래된 순'),
  HiGHEST_RATING("highestRating", "평점 높은 순"),
  LOWEST_RATiNG("lowestRating", "평점 낮은 순");

  const ListSortingButtonType(this.code, this.displayName);
  final String code;
  final String displayName;

  @override
  String toString() => displayName;

  factory ListSortingButtonType.getByCode(String code) {
    return ListSortingButtonType.values.firstWhere((value) => value.code == code,
        orElse: () => ListSortingButtonType.LATEST);
  }
}