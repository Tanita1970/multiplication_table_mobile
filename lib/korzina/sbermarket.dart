abstract class Product {
  String title;
  String category;
  double price;
  String country;
  String manufacturer;

  Product(
      this.title, this.category, this.price, this.country, this.manufacturer);

  void displayInfo();
}

class GroceryProduct extends Product {
  DateTime expirationDate;

  GroceryProduct(super.title, super.category, super.price, super.country,
      super.manufacturer, this.expirationDate);

  @override
  void displayInfo() {
    print('Продукт: $title');
    print('Категория: $category');
    print('Цена: $price руб.');
    print('Страна: $country');
    print('Производитель: $manufacturer');
    print('Срок годности: ${expirationDate.toLocal()}');
  }
}

class NonGroceryProduct extends Product {
  int warrantyPeriod;

  NonGroceryProduct(super.title, super.category, super.price, super.country,
      super.manufacturer, this.warrantyPeriod);

  @override
  void displayInfo() {
    print('Товар: $title');
    print('Категория: $category');
    print('Цена: $price руб.');
    print('Страна: $country');
    print('Производитель: $manufacturer');
    print('Гарантийный срок: $warrantyPeriod месяцев');
  }
}

void main() {
  List<Product> products = [
    GroceryProduct('Молоко', 'Молочные продукты', 60.0, 'Россия',
        'Простоквашино', DateTime.now().add(const Duration(days: 10))),
    NonGroceryProduct(
        'Телевизор', 'Электроника', 30000.0, 'Южная Корея', 'Samsung', 24),
    GroceryProduct('Хлеб', 'Выпечка', 30.0, 'Россия', 'Хлебный дом',
        DateTime.now().add(const Duration(days: 3))),
    NonGroceryProduct('Стиральная машина', 'Бытовая техника', 20000.0,
        'Германия', 'Bosch', 36),
  ];

  for (var product in products) {
    product.displayInfo();

    if (product is GroceryProduct) {
      // Специфические действия для продуктовых товаров
      print(
          'Продуктовый товар. Срок годности: ${product.expirationDate.toLocal()}');
    } else if (product is NonGroceryProduct) {
      // Специфические действия для непродуктовых товаров
      print(
          'Непродуктовый товар. Гарантийный срок: ${product.warrantyPeriod} месяцев');
    }
    print('');
  }
}
