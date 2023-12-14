import 'package:app_quitanda/src/pages/common_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:app_quitanda/src/config/app_data.dart' as app_data;

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
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
              onPressed: () {
                updatePassword();
              },
              child: const Text("Atualizar senha"),
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Titulo
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        "Atualização de senha",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Senha atual
                    const CustomTextField(
                      isSecret: true,
                      icon: Icons.lock,
                      labelText: "Senha atual",
                    ),
                    // Nova senha
                    const CustomTextField(
                      isSecret: true,
                      icon: Icons.lock_outline,
                      labelText: "Nova senha",
                    ),
                    // Confirmação nova senha
                    const CustomTextField(
                      isSecret: true,
                      icon: Icons.lock_outline,
                      labelText: "Confirmar nova senha",
                    ),

                    // Botão de confirmação
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("Atualizar"),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
