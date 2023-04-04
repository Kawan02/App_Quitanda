import 'package:app_quitanda/src/home/home_tab.dart';
import 'package:flutter/material.dart';

import '../config/custom_color.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          const HomeTab(),
          // Container(color: Colors.red),
          Container(color: Colors.blue),
          Container(color: Colors.green),
          Container(color: Colors.white),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
            pageController.jumpToPage(value);
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        unselectedItemColor: Colors.white.withAlpha(120),
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Carrinho",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Pedidos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Perfil",
          )
        ],
      ),
    );
  }
}
