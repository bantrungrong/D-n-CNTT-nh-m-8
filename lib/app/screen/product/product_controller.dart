import 'package:get/get.dart';

class SearchController extends GetxController {
  var searchText = ''.obs;
  var filteredProducts = <Map<String, dynamic>>[].obs;
  var allProducts = <Map<String, dynamic>>[].obs;

  void updateSearchText(String text) {
    searchText.value = text;
    filterProducts();
  }

  void filterProducts() {
    if (searchText.isEmpty) {
      filteredProducts.assignAll(allProducts);
    } else {
      filteredProducts.assignAll(allProducts.where((product) {
        return product['TenSanPham']
            .toString()
            .toLowerCase()
            .contains(searchText.toLowerCase());
      }).toList());
    }

    void setProducts(List<Map<String, dynamic>> products) {
      allProducts.assignAll(products);
      filterProducts();
    }
  }
}
