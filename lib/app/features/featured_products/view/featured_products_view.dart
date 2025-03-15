import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/commons/ppp_app_bar.dart';
import 'package:purple_planet_packaging/app/extensions/context_extensions.dart';
import '../../../commons/product_list_item.dart';
import '../../../core/utils/app_styles.dart';
import '../../shop/view/widgets/products_loading_gridview.dart';
import '../notifiers/product_featured_notifier.dart';

class FeaturedProductsView extends ConsumerStatefulWidget {
  static const routeName = '/featuredProducts';
  const FeaturedProductsView({Key? key}) : super(key: key);

  @override
  ConsumerState<FeaturedProductsView> createState() => _FeaturedProductsViewState();
}

class _FeaturedProductsViewState extends ConsumerState<FeaturedProductsView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          ref.read(featuredProductsNotifierProvider.notifier).loadMore();
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final featured = ref.watch(featuredProductsNotifierProvider);
    final isLoading = ref.watch(featuredProductsNotifierProvider).value?.isLoading ?? false;

    return Scaffold(
        appBar: const PPPAppBar(title: 'Featured Products'),
        body: Padding(
            padding: AppStyles.scaffoldPadding,
            child: featured.when(
              data: (data) => Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: context.isTablet ? 3 : 2,
                          childAspectRatio: context.isTablet ? 0.8 : 0.65,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: data.products.length,
                        itemBuilder: (context, index) {
                          return ProductListItem(
                            product: data.products[index],
                            // onTap: () {
                            //   context.pushNamed(
                            //     ProductDetailsView.routeName,
                            //     pathParameters: {'title': data.products[index].name},
                            //     extra: data.products[index],
                            //   );
                            // },
                          );
                        }),
                  ),
                  if (isLoading) const Center(child: LinearProgressIndicator())
                ],
              ),
              error: (Object error, StackTrace stackTrace) => Text(error.toString()),
              loading: () => const ProductsLoadingGridView(),
            )));
  }
}
