import 'package:app_quitanda/src/pages/ordens/components/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:app_quitanda/src/config/app_data.dart' as app_data;

class OrdensTab extends StatelessWidget {
  const OrdensTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedidos"),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, index) => const SizedBox(height: 10),
        itemCount: app_data.orders.length,
        itemBuilder: (_, index) => OrderTile(order: app_data.orders[index]),
      ),
    );
  }
}
