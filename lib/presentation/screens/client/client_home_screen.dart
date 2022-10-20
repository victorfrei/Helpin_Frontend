import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/data/env/environment.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/domain/models/response/category_all_response.dart';
import 'package:restaurant/domain/models/response/products_top_home_response.dart';
import 'package:restaurant/domain/services/services.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/helpers/date_custom.dart';
import 'package:restaurant/presentation/screens/client/cart_client_screen.dart';
import 'package:restaurant/presentation/screens/client/details_product_screen.dart';
import 'package:restaurant/presentation/screens/client/search_for_category_screen.dart';
import 'package:restaurant/presentation/screens/profile/list_addresses_screen.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';

class ClientHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    // Container(
                    //   height: 45,
                    //   width: 45,
                    //   decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       image: DecorationImage(
                    //           fit: BoxFit.cover,
                    //           image: NetworkImage(
                    //               '${Environment.endpointBase}${authBloc.state.user!.image}'))),
                    // ),
                    // const SizedBox(width: 40.0),
                    TextCustom(
                        textAlign: TextAlign.center,
                        text: DateCustom.getDateFrave() +
                            ', ${authBloc.state.user!.firstName}',
                        fontSize: 24,
                        color: Colors.white),
                  ],
                ),
                //   InkWell(
                //     onTap: () => Navigator.pushReplacement(
                //         context, routeFrave(page: CartClientScreen())),
                //     child: Stack(
                //       children: [
                //         const Icon(Icons.shopping_bag_outlined,
                //             size: 30, color: Colors.white),
                //         Positioned(
                //           right: 0,
                //           bottom: 5,
                //           child: Container(
                //               height: 20,
                //               width: 15,
                //               decoration: BoxDecoration(
                //                   color: Color(0xff0C6CF2),
                //                   shape: BoxShape.circle),
                //               child: Center(
                //                   child: BlocBuilder<CartBloc, CartState>(
                //                       builder: (context, state) => TextCustom(
                //                           text: state.quantityCart.toString(),
                //                           color: Colors.white,
                //                           fontWeight: FontWeight.bold,
                //                           fontSize: 15)))),
                //         ),
                //       ],
                //     ),
                //   )
              ],
            ),
            const SizedBox(height: 20.0),
            // const Padding(
            //     padding: EdgeInsets.only(right: 0.0),
            //     child: TextCustom(
            //         text: 'Escolha uma opção',
            //         fontSize: 28,
            //         maxLine: 2,
            //         fontWeight: FontWeight.w500)),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white!),
                      borderRadius: BorderRadius.circular(15.0)),
                  child: const Icon(Icons.place_outlined,
                      size: 38, color: Colors.white),
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextCustom(text: 'Endereço'),
                    InkWell(
                      onTap: () => Navigator.push(
                          context, routeFrave(page: ListAddressesScreen())),
                      child: BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) => TextCustom(
                                text: (state.addressName != '')
                                    ? state.addressName
                                    : 'Sem Registros',
                                color: ColorsFrave.primaryColor,
                                fontSize: 17,
                                maxLine: 1,
                              )),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 40.0),
            _ListOptions(),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationFrave(0),
    );
  }
}

class _ListProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Productsdb>>(
      future: productServices.getProductsTopHome(),
      builder: (_, snapshot) {
        final List<Productsdb>? listProduct = snapshot.data;

        return !snapshot.hasData
            ? Column(
                children: const [
                  ShimmerFrave(),
                  SizedBox(height: 10.0),
                  ShimmerFrave(),
                  SizedBox(height: 10.0),
                  ShimmerFrave(),
                ],
              )
            : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 220),
                itemCount: listProduct?.length,
                itemBuilder: (_, i) => Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(20.0)),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                DetailsProductScreen(product: listProduct[i]))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Hero(
                              tag: listProduct![i].id,
                              child: Image.network(
                                  'http://192.168.1.35:7070/' +
                                      listProduct[i].picture,
                                  height: 150)),
                        ),
                        TextCustom(
                            text: listProduct[i].nameProduct,
                            textOverflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                            color: ColorsFrave.primaryColor,
                            fontSize: 19),
                        const SizedBox(height: 5.0),
                        TextCustom(
                            text: '\$ ${listProduct[i].price.toString()}',
                            fontSize: 16,
                            fontWeight: FontWeight.w500)
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class _ListOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map> listProduct = [
      {"id": 1, "icon": "Assets/request.png", "name": "Solicitar Serviço"},
      {"id": 2, "icon": "Assets/requests.png", "name": "Ver Solicitações"}
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 25,
          mainAxisSpacing: 20,
          mainAxisExtent: 200),
      itemCount: listProduct.length,
      itemBuilder: (_, i) => Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.grey[50], borderRadius: BorderRadius.circular(20.0)),
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      DetailsProductScreen(product: listProduct[i]))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Hero(
                    tag: listProduct[i]["id"],
                    child: Image.asset(listProduct[i]["icon"], height: 150)),
              ),
              TextCustom(
                  text: listProduct[i]["name"],
                  textOverflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                  color: ColorsFrave.primaryColor,
                  fontSize: 19),
              const SizedBox(height: 5.0),
              // TextCustom(
              //     text: '\$ ${listProduct[i].price.toString()}',
              //     fontSize: 16,
              //     fontWeight: FontWeight.w500)
            ],
          ),
        ),
      ),
    );
  }
}
