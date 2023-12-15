import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:app_quitanda/src/config/app_data.dart' as app_data;
import 'package:app_quitanda/src/config/custom_color.dart';
import 'package:app_quitanda/src/pages/common_widgets/app_name_widget.dart';
import 'package:app_quitanda/src/pages/common_widgets/custom_shimmer.dart';
import 'package:app_quitanda/src/pages/home/components/category_tile.dart';
import 'package:app_quitanda/src/pages/home/components/item_tile.dart';
import 'package:app_quitanda/src/services/utils_services.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = "Frutas";
  final GlobalKey<CartIconKey> globalKey = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCartAnimation;

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCartAnimation(gkImage);
  }

  final UtilsServices utilsServices = UtilsServices();

  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const AppNameWidget(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {},
                child: badge.Badge(
                  badgeStyle: badge.BadgeStyle(badgeColor: CustomColors.customContrastColor),
                  badgeContent: const Text(
                    "2",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  child: AddToCartIcon(
                    key: globalKey,
                    icon: Icon(
                      Icons.shopping_cart,
                      color: CustomColors.customSwatchColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: AddToCartAnimation(
        gkCart: globalKey,
        previewDuration: const Duration(milliseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (receiveCreateAddToCardAnimationMethod) {
          runAddToCartAnimation = receiveCreateAddToCardAnimationMethod;
        },
        child: Column(
          children: [
            // Campo de pesquisa
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  hintText: "Pesquise aqui...",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: CustomColors.customContrastColor,
                    size: 21,
                  ),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),

            // Categorias
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 25),
              child: Visibility(
                visible: !isLoading,
                replacement: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    10,
                    (index) {
                      return Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 12),
                        child: CustomShimmer(
                          height: 20,
                          width: 80,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    },
                  ),
                ),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return CategoryTile(
                      category: app_data.categorias[index],
                      isSelected: app_data.categorias[index] == selectedCategory,
                      onPressed: () {
                        setState(() {
                          selectedCategory = app_data.categorias[index];
                        });
                      },
                    );
                  },
                  separatorBuilder: (_, index) => const SizedBox(width: 10),
                  itemCount: app_data.categorias.length,
                ),
              ),
            ),

            // Grid
            Expanded(
              child: Visibility(
                visible: !isLoading,
                replacement: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 9 / 11.5,
                  children: List.generate(
                    10,
                    (index) {
                      return CustomShimmer(
                        height: double.infinity,
                        width: double.infinity,
                        borderRadius: BorderRadius.circular(20),
                      );
                    },
                  ),
                ),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 9 / 11.5,
                  ),
                  itemCount: app_data.items.length,
                  itemBuilder: (_, index) {
                    return ItemTile(
                      item: app_data.items[index],
                      cartAnimationMethod: itemSelectedCartAnimations,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
