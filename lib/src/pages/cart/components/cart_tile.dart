import 'package:app_quitanda/src/config/custom_color.dart';
import 'package:app_quitanda/src/models/cart_item_model.dart';
import 'package:app_quitanda/src/pages/common_widgets/quantity_widget.dart';
import 'package:app_quitanda/src/services/utils_services.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  final CartItemModel cartItem;
  CartTile({super.key, required this.cartItem});

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        // Imagem
        leading: Image.asset(
          cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),

        // Titulo
        title: Text(
          cartItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        // Total
        subtitle: Text(
          utilsServices.priceToCurrency(cartItem.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Quantidade
        trailing: QuantityWidget(
          value: cartItem.quantity,
          suffixText: cartItem.item.unit,
          result: (quantity) {},
        ),
      ),
    );
  }
}
