import 'package:e_commerce_app/features/shop/controllers/product/variation_controller.dart';
import 'package:e_commerce_app/features/shop/models/cart_item_model.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:e_commerce_app/utils/local_storage/storage_utility.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  /// Variables
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItem = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  @override
  void onInit() {
    super.onInit();
    loadCartItems();
  }

  // Add Items in the cart
  void addToCart(ProductModel product) {
    // Quantity check
    if (productQuantityInCart.value < 1) {
      TLoaders.customToast(message: 'Select Quantity');
      return;
    }

    // Variation Selection
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      TLoaders.warningSnackBar(
          title: 'Select Variation', message: 'No Variation is selected');
      return;
    }

    // Out of Stock
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        TLoaders.warningSnackBar(
            title: 'Oh Snap!', message: 'Selected Variation Is Out of Stock');
        return;
      }
    } else {
      if (product.stock < 1) {
        TLoaders.warningSnackBar(
            title: 'Oh Snap!', message: 'Selected Variation Is Out of Stock');
        return;
      }
    }

    // Convert the product to CartItem with given quantity
    final selectedCartItem =
        convertToCartItem(product, productQuantityInCart.value);

    // Check if the above cartItem is already added in the cart or not
    int index = cartItem.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);

    // If index is greater than or equal to 0 then it means that the item is already added in the cart because the index starts from 0 and looped through all items else it will returns nothing
    if (index >= 0) {
      // This quantity is already added or updated/removed from the Cart
      cartItem[index].quantity = selectedCartItem.quantity;
    } else {
      // This means that the item is not been added previously.
      cartItem.add(selectedCartItem);
    }

    // Up till now the Item has been added to the Cart
    // Now we have to update the CartItem variables like (noOfCartItems, totalCartPrice)
    updateCart();
    TLoaders.customToast(message: 'Your Product has been added to the Cart.');
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItem.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      cartItem[index].quantity += 1;
    } else {
      cartItem.add(item);
    }

    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItem.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      if (cartItem[index].quantity > 1) {
        cartItem[index].quantity -= 1;
      } else {
        // Show dialog before completely removing items from cart
        cartItem[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItem.removeAt(index);
      }
    }

    updateCart();
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        // Remove the item from the cart
        cartItem.removeAt(index);
        updateCart();
        TLoaders.customToast(message: 'Product has been removed from the cart');
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

  // First Convert the product to the CartItemModel
  /// This function converts the product to CartItemModel
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      // Reset Variation in case of single product type
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;

    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  /// Update Cart Values
  void updateCart() {
    updateCartTotal();
    saveCartItems(); // This will save the new cart Items details to storage
    cartItem.refresh();
  }

  void updateCartTotal() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItem) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItem.map((item) => item.toJson()).toList();
    TLocalStorage.instance().saveData('cartItems', cartItemStrings);
  }

  void loadCartItems() async {
    try {
      final cartItemStrings =
          TLocalStorage.instance().readData<List<dynamic>>('cartItems');
      if (cartItemStrings != null) {
        cartItem.assignAll(cartItemStrings.map(
            (item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
        updateCartTotal();
      }
    } catch (e) {
      print('Failed to load cart items: $e');
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItem
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItem.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );
    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItem.clear();
    updateCart();
  }

  /// -- Initialize already added Item's Count in cart.
  void updateAlreadyAddedProductCount(ProductModel product) {
    // If product has no variations then calculate cartEntries and display total number
    // Else make default entries to 0 and show cartEntries when variation is selected.
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      // Get selected Variation if any...
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value =
            getVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }
}
