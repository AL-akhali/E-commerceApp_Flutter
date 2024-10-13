class CategoryModel{
  int? id;
  String? url;
  String? title;

  CategoryModel.fromJson({required Map<String,dynamic>data})
  {
    id = data['id'];
    url = data['image'];
    title = data['name'];
  }
}