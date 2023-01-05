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
          "You don\'t have an order yet": "Bạn chưa có đơn hàng nào",
          "You don\'t have an active orders at this time":
              "Hiện tại bạn chưa có đơn hàng nào giao",
          "You don\'t have a complete orders at this time":
              "Hiện tại bạn chưa có đơn hàng nào hoàn thành",
          "You don\'t have a cancel orders at this time":
              "Hiện tại bạn chưa có đơn hàng nào đã hủy",
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
          "Biometric ID": "Bảo mật vân tay",
          "Change PIN": "Thay đổi mã PIN",
          "Change Password": "Thay đổi mật khẩu",
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
          "hello": "xin chào",
          //search screen
      "Search":"Tìm kiếm",
      "Recent":"Gần đây",
      "Clear All":"Xóa tất cả",
      "Results for":"Kết quả cho",
      "found":"kết quả",
      "Men":"Nam",
      "Women":"Nữ",
      "Price High":"Giá Tằng",
      "Price Low":"Giá Giảm",
      "Reset":"Đặt lại",
      "Apply":"Áp dụng",
      "All":"Tất cả",
      "Categories":"Danh mục",
      "Gender":"Giới tính",
      "Sort by":"Xếp theo",
      'Sort & Filter':"Sắp xếp & Lọc",
      'Price Range':"Phạm vi giá",
      'Not found':"Không tìm thấy",
      'Sorry, the keyword you entered can\'t be found. Please check again or search with another keyword':"Rất tiếc, không thể tìm thấy từ khóa bạn đã nhập. Vui lòng kiểm tra lại hoặc tìm với từ khóa khác",
      //checkout screen
      "Checkout":"Thanh toán",
      "Shipping Address":"Địa chỉ giao hàng",
      "Order List":"Danh sách sản phẩm",
      "Promo":"Khuyến mãi",
      "Note":"Ghi chú",
      'Enter Note':"Nhập ghi chú",
      'Amount':"Tiền sản phẩm",
      'Shipping':"Phí vận chuyển",
      'Total':"Tổng cộng",
      "Continue to Payment":"Tiếp tục thanh toán",
      "Add New Address":"Thêm địa chỉ mới",
      "Choose voucher":"Chọn khuyến mãi",
      //Voucher page
      "Voucher":"Khuyến mãi",
      //method payment
      "Payment Methods":"Phương thức thanh toán",
      "Select the payment method you want to use.":"Chọn phương thức thanh toán mà bạn muốn sử dụng.",
      "Cash":"Tiền mặt",
      "Confirm Payment":"Xác nhận thanh toán",
      //add address page
      "New Address":"Địa chỉ mới",
      "Name":"Tên",
      "Phone":"Số điện thoại",
      "Province":"Tỉnh/Thành phố",
      "District":"Quận/Huyện",
      "Ward":"Phường/Xã",
      "Detail":"Chi tiết",
      "Set as default":"Đặt làm mặc định",
      "Submit":"Hoàn thành",
      "Required":"Bắt buộc",
      "You haven't selected a payment method!":"Bạn chưa chọn phương thức thanh toán!",
      //update address screen
      "Update Address":"Cập nhật địa chỉ",
      "Delete":"Xóa",
      "Invalid phone":"Số điện thoại không hợp lệ",
      //Main
      "Home":"Trang chủ",
      "Cart":"Giỏ hàng",
      "Orders":"Đơn hàng",
      "Profile":"Cá nhân",
      //Home
      "Good Morning":"Chào buổi sáng",
      "Good Afternoon":"Chào buổi trưa",
      "Good Everning":"Chào buổi chiều",
          "Search": "Tìm kiếm",
          "Recent": "Gần đây",
          "Clear All": "Xóa tất cả",
          "Results for": "Kết quả cho",
          "found": "kết quả",
          "Men": "Nam",
          "Women": "Nữ",
          "Price High": "Giá Tằng",
          "Price Low": "Giá Giảm",
          "Reset": "Đặt lại",
          "Apply": "Áp dụng",
          "All": "Tất cả",
          "Categories": "Danh mục",
          "Gender": "Giới tính",
          "Sort by": "Xếp theo",
          'Sort & Filter': "Sắp xếp & Lọc",
          'Price Range': "Phạm vi giá",
          "Checkout": "Thanh toán",
          "Shipping Address": "Địa chỉ giao hàng",
          "Order List": "Danh sách sản phẩm",
          "Promo": "Khuyến mãi",
          "Note": "Ghi chú",
          'Enter Note': "Nhập ghi chú",
          'Amount': "Tiền sản phẩm",
          'Shipping': "Phí vận chuyển",
          'Total': "Tổng cộng",
          "Continue to Payment": "Tiếp tục thanh toán",
          "Add New Address": "Thêm địa chỉ mới",
          "Choose voucher": "Chọn khuyến mãi",
          //Voucher page
          "Voucher": "Khuyến mãi",
          //method payment
          "Payment Methods": "Phương thức thanh toán",
          "Select the payment method you want to use.":
              "Chọn phương thức thanh toán mà bạn muốn sử dụng.",
          "Cash": "Tiền mặt",
          "Confirm Payment": "Xác nhận thanh toán",
          //add address page
          "New Address": "Địa chỉ mới",
          "Name": "Tên",
          "Phone": "Số điện thoại",
          "Province": "Tỉnh/Thành phố",
          "District": "Quận/Huyện",
          "Ward": "Phường/Xã",
          "Detail": "Chi tiết",
          "Set as default": "Đặt làm mặc định",
          "Submit": "Hoàn thành",
          "Required": "Bắt buộc",
          "You haven't selected a payment method!":
              "Bạn chưa chọn phương thức thanh toán!",
          //update address screen
          "Update Address": "Cập nhật địa chỉ",
          "Delete": "Xóa",
          "Invalid phone": "Số điện thoại không hợp lệ",
          //Main
          "Home": "Trang chủ",
          "Cart": "Giỏ hàng",
          "Orders": "Đơn hàng",
          "Profile": "Cá nhân",
          //Home
          "Good Morning": "Chào buổi sáng",
          "Good Afternoon": "Chào buổi trưa",
          "Good Everning": "Chào buổi chiều",
          //success screen
          "Order Complete!":"Đơn hàng thành công!",
          "Your payment was successful!":"Thanh toán của bạn đã thành công!",
          "Back To Home":"Trở về Trang Chủ",
          //fail screen
          "Order Failed!":"Đặt hàng không thành công!",
          "Oops! An error occured while approving the order. You can try again.":"Rất tiếc! Đã xảy ra lỗi khi phê duyệt đơn đặt hàng. Bạn có thể thử lại.",
          "Try Again":"Thử Lại"
        },
      };
  final _box = GetStorage();
  final _key = 'lang';
  Locale get locale => _loadLanguageForBox();
  void switchLang() {
    Get.updateLocale(_loadLanguageForBox() == Locale("vi", "VN")
        ? Locale("en", "US")
        : Locale("vi", "VN"));
    _saveLangToBox(
        _loadLanguageForBox() == Locale("vi", "VN") ? "en-US" : "vi-VN");
  }

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
}
