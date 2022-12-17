import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationService extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        "en_US": {
          "hello": "hello",
          // Home Page
          "Good Morning": "Good Morning",
          "Special Offers": "Special Offers",
          "See all": "See all",
          "More Popular": "More Popular",
          "Search": "Search",
          // Card Page
          "My Cart": "My Cart",
          "Total price": "Total price",
          "Checkout": "Checkout",
          // Order Page
          "My orders": "My orders",
          "Active": "Active",
          "Completed": "Completed",
          "Canceled": "Canceled",
          // Profile Page
          "Profile": "Profile",
          "Edit Profile": "Edit Profile",
          "Address": "Address",
          "Security": "Security",
          "Language": "Language",
          "Dark Mode": "Dark Mode",
          "Privacy Police": "Privacy Police",
          "Help Center": "Help Center",
          "Sign out": "Sign out",
          // Product Screen
          "All": "All",
          // Product Detail
        },
        "vi_VN": {
          "hello": "xin chào",
          // Home Page
          "Good Morning": "Chào buổi sáng",
          "Special Offers": "Ưu đãi đặc biệt",
          "See all": "Xem tất cả",
          "More Popular": "Phổ biến",
          "Search": "Tìm kiếm",
          // Card Page
          "My Cart": "Giỏ hàng",
          "Total price": "Tổng tiền",
          "Checkout": "Mua hàng",
          // Order Page
          "My orders": "Đơn hàng",
          "Active": "Đang giao",
          "Completed": "Hoàn thành",
          "Canceled": "Đã hủy",
          "Date Created: ": "Ngày tạo: ",
          "Date Completed: ": "Ngày hoàn thành: ",
          "Date Canceled: ": "Ngày hủy: ",
          "packing": 'đang giao',
          "completed": 'hoàn thành',
          "canceled": 'đã hủy',
          "Track Order": "Theo dõi",
          "Re-Order": "Đặt lại",
          "View Detail": "Xem chi tiết",
          // Track order
          "Package is Packing": "Đơn hàng đang đóng gói",
          "Package in Delivery": "Đơn hàng đang vận chuyển",
          "Package is Delivered": "Đơn hàng đã giao",
          "Package is Completed": "Đơn hàng đã hoàn thành",
          "Package is Canceled": "Đơn hàng đã hủy",
          " | Qty = ": " | SL = ",
          "Total price: ": "Tổng tiền: ",
          "Order status detail": "Chi tiết trạng thái đơn hàng",
          "Review": "Đánh giá",
          "Delivery Address": "Địa chỉ",
          "ID Order": "ID đơn hàng",
          "Cancel": "Hủy",
          "Date Created": "Ngày tạo",
          "Date Delivered": "Ngày giao",
          "Date Completed": "Ngày hoàn thành",
          "Date Canceled": "Ngày hủy",
          // Profile Page
          "Profile": "Cá nhân",
          "Edit Profile": "Chỉnh sửa thông tin",
          "Address": "Địa chỉ",
          "Security": "Bảo mật",
          "Language": "Ngôn ngữ",
          "Dark Mode": "Chế độ tối",
          "Privacy Police": "Chính sách riêng tư",
          "Help Center": "Trung tâm trợ giúp",
          "Sign out": "Đăng xuất",
          // Product Screen
          "All": "Tât cả",
          "Sort & Filter": "Sắp xếp & lọc",
          "Sort by": "Sắp xếp theo",
          "Price: Low-High": "Giá: Thấp-Cao",
          "Price: High-Low": "Giá: Cao-Thấp",
          "Gender": "Giới tính",
          "Men": "Nam",
          "Women": "Nữ",
          "Reset": "Đặt lại",
          "Apply": "Áp dụng",
          // Product Detail
          ' sold': ' Đã bán',
          'reviews)': 'Đánh giá)',
          'Description': 'Mô tả',
          'See more...': 'Xem thêm...',
          "See less...": "Xem ít hơn...",
          "Size": "Kích thước",
          "Quantity": "Số lượng",
          "Add to Card": "Thêm vào giỏ",
          "Product successfully added to cart": "Thêm hàng vào giỏ thành công",
          // Help Center
          "Help Center": "Trung tâm trợ giúp",
          "Contact us": "Liên hệ",
          "Customer Service": "Chăm sóc khách hàng",
        },
      };
  final _box = GetStorage();
  final _key = 'lang';
  _saveLangToBox(String lang) => _box.write(_key, lang);
  Locale _loadLanguageForBox() {
    if (_box.read(_key) == null) {
      return Locale("en", "US");
    } else {
      if (_box.read(_key) == "vi-VN") {
        return Locale("vi", "VN");
      } else {
        return Locale("en", "US");
      }
    }
  }

  Locale get locale => _loadLanguageForBox();
  void switchLang() {
    Get.updateLocale(_loadLanguageForBox() == Locale("vi", "VN")
        ? Locale("en", "US")
        : Locale("vi", "VN"));
    _saveLangToBox(
        _loadLanguageForBox() == Locale("vi", "VN") ? "en-US" : "vi-VN");
  }
}