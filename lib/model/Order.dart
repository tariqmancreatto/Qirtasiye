class Order {
  final String id;
  final String productName;
  final String productQuantity;
  final String productPrice;
  final String status;
  final String address;
  final String customerName;

  Order(
      {this.id,
      this.productName,
      this.productQuantity,
      this.productPrice,
      this.status,
      this.address,
      this.customerName});
}