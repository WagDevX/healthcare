import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthcare/components/alert_dialog.dart';
import 'package:healthcare/models/configuracoes_model.dart';
import 'package:healthcare/repositories/configuracoes_repository.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late ConfiguracoesRepository configuracoesRepository;
  var configuracoesModel = ConfiguracoesModel.vazio();

  var nomeUsuarioController = TextEditingController();
  var alturaController = TextEditingController();
  String? nomeUsuario;
  double? altura;
  bool carregandoDados = false;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    carregandoDados = true;
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoesRepository.obterDados();
    nomeUsuarioController.text = configuracoesModel.nomeUsuario;
    alturaController.text = configuracoesModel.altura.toString();
    carregandoDados = false;
    setState(() {});
  }

  Future salvaDados() async {
    try {
      configuracoesModel.altura = (double.parse(alturaController.text));
    } catch (e) {
      if (mounted) {
        CustomDialog.show(context, "Digite uma altura válida");
      }
      return;
    }
    configuracoesModel.nomeUsuario = (nomeUsuarioController.text);
    configuracoesRepository.salvar(configuracoesModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Configurações"),
      ),
      body: Container(
        child: carregandoDados
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 25),
                    child: TextField(
                      decoration: const InputDecoration(
                          label: Text("Usuário"),
                          hintText: "Usuário",
                          alignLabelWithHint: true,
                          suffixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      controller: nomeUsuarioController,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.height),
                        label: Text("Altura"),
                        hintText: "Altura",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      controller: alturaController,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SwitchListTile(
                      title: const Text("Notificações"),
                      value: configuracoesModel.receberNotificacoes,
                      secondary: configuracoesModel.receberNotificacoes
                          ? const Icon(
                              Icons.notifications_active,
                              color: Colors.blue,
                            )
                          : const Icon(Icons.notifications_off),
                      onChanged: (bool value) {
                        setState(() {
                          configuracoesModel.receberNotificacoes = value;
                        });
                      }),
                  SwitchListTile(
                      title: const Text("Tema do aplicativo"),
                      secondary: configuracoesModel.temaEscuro
                          ? const Icon(
                              Icons.dark_mode,
                              color: Colors.lightBlue,
                            )
                          : const Icon(
                              Icons.light_mode,
                              color: Colors.yellow,
                            ),
                      value: configuracoesModel.temaEscuro,
                      onChanged: (bool value) {
                        setState(() {
                          configuracoesModel.temaEscuro = value;
                        });
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        await salvaDados();
                        Timer(const Duration(milliseconds: 150), () {
                          Navigator.pop(context);
                        });
                      },
                      child: const Text("Salvar configurações"))
                ],
              ),
      ),
    );
  }
}
