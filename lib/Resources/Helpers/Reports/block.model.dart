class BlockModel {
  final String title;
  final List<String> fields;
  final Map data;
  String? type, blockFooter;

  BlockModel(
      {required this.title,
      required this.fields,
      required this.data,
      this.type = 'row',
      this.blockFooter});
}
