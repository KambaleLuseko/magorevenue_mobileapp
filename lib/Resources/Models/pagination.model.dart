class PaginationModel {
  int page = 1, limit = 10;
  bool? hasNext = true, hasPrevious = false;
  PaginationModel(
      {required this.page,
      required this.limit,
      this.hasPrevious = false,
      this.hasNext = true});
}
