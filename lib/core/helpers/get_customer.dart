import 'package:get/get.dart';
import 'package:food_app/core/models/customer_model.dart';

class CustomerController extends GetxController {
  // Reactive customer data
  var customer = Rxn<Customer>();

  // Method to update customer data
  void updateCustomer(Customer newCustomer) {
    customer.value = newCustomer;
  }
}
