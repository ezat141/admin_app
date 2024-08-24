class AppLink {
  static const String server = "https://ecommerce-4hlw.onrender.com";
//

// ================================= Auth ========================== //

  static const String login = "$server/admin/login";

  // ================================= ForgetPassword ========================== //

  static const String checkEmail = "$server/forgetPassword/checkEmail";
  static const String verifycodeforgetpassword =
      "$server/forgetPassword/verifyCode";
  static const String resetPassword = "$server/forgetPassword/resetPassword";

  // Home

  static const String homepage = "$server/home";

  // static const String viewPendingOrders = "$server/delivery/deliveryPending";
  // static const String viewAcceptedOrders = "$server/delivery/deliveryAccepted";
  // static const String approveOrders = "$server/delivery/deliveryApprove";
  // static const String viewArchivedOrders = "$server/delivery/deliveryArchive";
  // static const String ordersdetails = "$server/orders/ordersDetailsView";
  // static const String doneDelivery = "$server/delivery/deliveryDone";


  // Categories
  static const String categoriesview = "$server/admin/getCategories";
  static const String categoriesadd = "$server/admin/createCategory";
  static const String categoriesedit = "$server/admin/updateCategory";
  static const String categoriesdelete = "$server/admin/deleteCategory";

  // Products
  static const String productsview = "$server/admin/getProducts";
  static const String productsadd = "$server/admin/createProduct";
  static const String productsedit = "$server/admin/updateProduct";
  static const String productsdelete = "$server/admin/deleteProduct";

  // Orders
  static const String approveOrder = "$server/admin/ordersApprove";
  static const String prepare = "$server/admin/ordersPrepared";

  static const String viewarchiveOrder = "$server/admin/ordersArchive";
  static const String viewpendingOrders = "$server/admin/ordersPending";
  static const String viewacceptedOrders = "$server/admin/ordersAccepted";
  static const String detailsOrders = "$server/admin/ordersDetailsView";


}
