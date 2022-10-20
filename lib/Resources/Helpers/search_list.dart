searchList(
    {required List data,
    required String firstSearchColumn,
    String? secondSearchColumn,
    required String value,
    required callback}) {
  List filteredData = [];
  if (secondSearchColumn == null && firstSearchColumn.isNotEmpty) {
    filteredData = data.where((singleData) {
      return singleData[firstSearchColumn]
          .toString()
          .trim()
          .toLowerCase()
          .contains(value.toLowerCase().trim());
    }).toList();
    callback(filteredData);
    return;
  }
  if (secondSearchColumn != null &&
      secondSearchColumn.isNotEmpty &&
      firstSearchColumn.isNotEmpty) {
    filteredData = data.where((singleData) {
      return singleData[firstSearchColumn]
              .toString()
              .trim()
              .toLowerCase()
              .contains(value.toLowerCase().trim()) ||
          singleData[secondSearchColumn]
              .toString()
              .trim()
              .toLowerCase()
              .contains(value.toLowerCase().trim());
    }).toList();
    callback(filteredData);
    return;
  }
}
