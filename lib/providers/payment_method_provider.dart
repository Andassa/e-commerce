import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PaymentMethod { paypal, creditCard, cash }

final paymentMethodProvider =
    StateProvider<PaymentMethod>((ref) => PaymentMethod.creditCard);
