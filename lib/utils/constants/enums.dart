/// List of Enums
/// They Cannot be created inside a class.
library;

enum ProductType { single, variable }

enum TextSizes { small, medium, large }

enum OrderStatus { processing, shipped, delivered, pending, cancelled }

enum PaymentMethod {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
  paystack,
  razorPay,
  paytm
}
