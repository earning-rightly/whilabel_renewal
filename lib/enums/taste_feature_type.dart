enum TasteFeatureType {
  BODY("bodyRate", "바디감"),
  FLAVOR("flavorRate", '향'),
  PEAT("peatRate", "피트감");


  const TasteFeatureType(this.code, this.displayName);
  final String code;
  final String displayName;

  @override
  String toString() => displayName;

}