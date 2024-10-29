import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:purple_planet_packaging/app/models/categories/term.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/products/product.dart';
import '../repository/shop_repository_impl.dart';

part 'food_type_notifier.g.dart';

@Riverpod(keepAlive: true)
class FoodTypeNotifier extends _$FoodTypeNotifier {
  @override
  FutureOr<List<Term>> build() async {
    final terms = await ref.read(shopRepositoryProvider).getFoodTypes();

    terms.removeWhere((element) => element.count == 0);

    return terms;
  }
}

@Riverpod(keepAlive: true)
class FoodTypeProductsNotifier extends _$FoodTypeProductsNotifier {
  @override
  FutureOr<List<Product>> build(String term) {
    return ref.read(shopRepositoryProvider).getProductsByTerm(term);
  }
}
