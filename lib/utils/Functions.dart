class Functions {
  List oneToMulti(List _item, int _count) {
    int _colsPerRow = (_item.length / _count).ceil();
    List output = List.generate(_colsPerRow, (i) => [], growable: true);
    for (int i = 0; i < _colsPerRow; i++) {
      for (int j = 0; j < _count; j++) {
        if (_count * i + j < _item.length) output[i].add(_item[_count * i + j]);
      }
    }
    return output;
  }
}
