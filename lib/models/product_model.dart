class ProductModel
{
  String? name;
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? url;
  String? description;

  ProductModel.fromJson({required Map<String,dynamic>data})
  {
    id = data['id'].toInt();
    price = data['price'].toInt();
    oldPrice = data['old_price'].toInt();
    discount = data['discount'].toInt();
    url = data['image'].toString();
    name = data['name'].toString();
    description = data['description'].toString();
  }
}