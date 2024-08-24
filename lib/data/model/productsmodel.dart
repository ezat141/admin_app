// class ProductsModel {
//   String? sId;
//   String? productName;
//   String? productNameAr;
//   String? productDesc;
//   String? productDescAr;
//   String? image;
//   int? productCount;
//   bool? productActive;
//   int? productPrice;
//   int? productDiscount;
//   String? productCat;
//   String? productDate;
//   bool? favorite;


//   ProductsModel(
//       {this.sId,
//       this.productName,
//       this.productNameAr,
//       this.productDesc,
//       this.productDescAr,
//       this.image,
//       this.productCount,
//       this.productActive,
//       this.productPrice,
//       this.productDiscount,
//       this.productCat,
//       this.productDate,
//       this.favorite});

//   ProductsModel.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     productName = json['product_name'];
//     productNameAr = json['product_name_ar'];
//     productDesc = json['product_desc'];
//     productDescAr = json['product_desc_ar'];
//     image = json['image'];
//     productCount = json['product_count'];
//     productActive = json['product_active'];
//     productPrice = json['product_price'];
//     productDiscount = json['product_discount'];
//     productCat = json['product_cat'];
//     productDate = json['product_date'];
//     favorite = json['favorite'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['product_name'] = this.productName;
//     data['product_name_ar'] = this.productNameAr;
//     data['product_desc'] = this.productDesc;
//     data['product_desc_ar'] = this.productDescAr;
//     data['image'] = this.image;
//     data['product_count'] = this.productCount;
//     data['product_active'] = this.productActive;
//     data['product_price'] = this.productPrice;
//     data['product_discount'] = this.productDiscount;
//     data['product_cat'] = this.productCat;
//     data['product_date'] = this.productDate;
//     data['favorite'] = this.favorite;
//     return data;
//   }
// }



////////////////////////////////////////////////////////
class ProductsModel {
  String? sId;
  String? productName;
  String? productNameAr;
  String? productDesc;
  String? productDescAr;
  String? image;
  int? productCount;
  bool? productActive;
  int? productPrice;
  int? productDiscount;
  String? productDate;
  String? categoryId;
  String? categoryName;
  String? categoryNameAr;

  ProductsModel(
      {this.sId,
      this.productName,
      this.productNameAr,
      this.productDesc,
      this.productDescAr,
      this.image,
      this.productCount,
      this.productActive,
      this.productPrice,
      this.productDiscount,
      this.productDate,
      this.categoryId,
      this.categoryName,
      this.categoryNameAr});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['product_name'];
    productNameAr = json['product_name_ar'];
    productDesc = json['product_desc'];
    productDescAr = json['product_desc_ar'];
    image = json['image'];
    productCount = json['product_count'];
    productActive = json['product_active'];
    productPrice = json['product_price'];
    productDiscount = json['product_discount'];
    productDate = json['product_date'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryNameAr = json['category_name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['product_name'] = this.productName;
    data['product_name_ar'] = this.productNameAr;
    data['product_desc'] = this.productDesc;
    data['product_desc_ar'] = this.productDescAr;
    data['image'] = this.image;
    data['product_count'] = this.productCount;
    data['product_active'] = this.productActive;
    data['product_price'] = this.productPrice;
    data['product_discount'] = this.productDiscount;
    data['product_date'] = this.productDate;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['category_name_ar'] = this.categoryNameAr;
    return data;
  }
}

