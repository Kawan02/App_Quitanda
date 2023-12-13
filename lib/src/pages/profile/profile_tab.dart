import 'package:app_quitanda/src/pages/common_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:app_quitanda/src/config/app_data.dart' as app_data;

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil do usuário"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //Nome
          CustomTextField(
            readOnly: true,
            icon: Icons.person,
            labelText: "Nome",
            initialValue: app_data.user.name,
          ),
          // Email
          CustomTextField(
            readOnly: true,
            icon: Icons.email,
            labelText: "E-mail",
            initialValue: app_data.user.email,
          ),
          //Celular
          CustomTextField(
            readOnly: true,
            icon: Icons.phone,
            labelText: "Telefone",
            initialValue: app_data.user.phone,
          ),
          //CPF
          CustomTextField(
            readOnly: true,
            icon: Icons.file_copy,
            labelText: "CPF",
            isSecret: true,
            initialValue: app_data.user.cpf,
          ),
          //Botão para atualizar a senha
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.green,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              onPressed: () {},
              child: const Text("Atualizar senha"),
            ),
          )
        ],
      ),
    );
  }
}
