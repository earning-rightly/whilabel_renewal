class MockWhiskey {
  MockWhiskey({
    required this.id,
    required this.barcode,
    required this.name,
    this.distilleryIds,
    this.wbId,
    this.wbWhisky,
  });
  final String id;
  final String name;
  final String barcode;
  String? imgUrl;
  String? wbId;
  Map<String, dynamic>? wbWhisky;
  final List<String>? distilleryIds;

}