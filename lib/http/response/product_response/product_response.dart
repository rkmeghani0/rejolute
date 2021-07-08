class ProductResponse {
  dynamic status;
  String? message;
  dynamic totalRecord;
  dynamic perPage;
  dynamic totalPage;
  List<Product>? product;

  ProductResponse(
      {this.status,
      this.message,
      this.totalRecord,
      this.perPage,
      this.totalPage,
      this.product});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalRecord = json['totalRecord'];
    perPage = json['perPage'];
    totalPage = json['totalPage'];
    if (json['data'] != null) {
      product = [];
      json['data'].forEach((v) {
        product?.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['totalRecord'] = this.totalRecord;
    data['perPage'] = this.perPage;
    data['totalPage'] = this.totalPage;
    if (this.product != null) {
      data['data'] = this.product?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  dynamic id;
  String? slug;
  String? title;
  String? description;
  dynamic price;
  String? featuredImage;
  String? status;
  String? createdAt;

  Product(
      {this.id,
      this.slug,
      this.title,
      this.description,
      this.price,
      this.featuredImage,
      this.status,
      this.createdAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    featuredImage = json['featured_image'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['featured_image'] = this.featuredImage;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
