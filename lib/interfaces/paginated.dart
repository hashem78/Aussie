abstract class Pagniated<T> {
  void filter(String searchValue);
  Future<void> loadMoreAsync(int amount);
  void returnToCurrent();
  List<T> currentData;
}
