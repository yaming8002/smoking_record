class PageTextSizes {
  Map<String, double> _sizeMap = {};

  // Getter for sizeMap
  Map<String, double> get sizeMap => _sizeMap;

  // Setter for sizeMap
  void setSize(String key, double value) {
    _sizeMap[key] = value;
  }

  // Method to get a specific size by key
  double? getSize(String key) {
    return _sizeMap[key];
  }

  // Method to remove a specific size by key
  void removeSize(String key) {
    _sizeMap.remove(key);
  }

  // Clear all sizes
  void clearSizes() {
    _sizeMap.clear();
  }
}
