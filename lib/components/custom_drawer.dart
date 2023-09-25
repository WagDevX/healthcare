import 'package:flutter/material.dart';
import 'package:healthcare/models/configuracoes_model.dart';
import 'package:healthcare/pages/configuracoes_page.dart';
import 'package:healthcare/pages/welcome_page.dart';
import 'package:healthcare/repositories/configuracoes_repository.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late ConfiguracoesRepository configuracoesRepository;
  var configuracoesModel = ConfiguracoesModel.vazio();
  String usuario = "";

  void carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoesRepository.obterDados();
    usuario = configuracoesModel.nomeUsuario;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.horizontal(right: Radius.circular(40))),
          backgroundColor: Colors.blue[50],
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        context: context,
                        builder: (BuildContext bc) {
                          return const Wrap(
                            children: [
                              ListTile(
                                title: Text("Câmera"),
                                leading: Icon(Icons.add_a_photo),
                              ),
                              ListTile(
                                title: Text("Galeria"),
                                leading: Icon(Icons.collections),
                              )
                            ],
                          );
                        });
                  },
                  child: UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.lightBlueAccent,
                            Colors.lightBlue
                          ], begin: Alignment.topCenter),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40))),
                      currentAccountPicture: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://wagner-portfolio.web.app/static/media/me-about3.4837e3a48d23bc5238ae.jpg"),
                      ),
                      accountName: Text(usuario),
                      accountEmail: const Text("email@gmail.com")),
                ),
                const SizedBox(height: 15),
                InkWell(
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      width: double.infinity,
                      child: const Row(
                        children: [
                          Icon(Icons.info),
                          SizedBox(width: 5),
                          Text("Termos de uso e privacidade"),
                        ],
                      )),
                  onTap: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        context: context,
                        builder: (BuildContext bc) {
                          return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: const Column(
                                children: [
                                  Text(
                                    "Termos de uso e privacidade",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '"O desejo portanto, os processos oníricos — e, por extensão, todo o inconsciente — foraclui o ponto de fundação que define o modo de relação do sujeito com o seu sofrimento."',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ));
                        });
                  },
                ),
                const SizedBox(height: 15),
                InkWell(
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      width: double.infinity,
                      child: const Row(
                        children: [
                          Icon(Icons.construction_rounded),
                          SizedBox(width: 5),
                          Text("Configurações"),
                        ],
                      )),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConfiguracoesPage()));
                  },
                ),
                const SizedBox(height: 15),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: const Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 5),
                        Text("SAIR")
                      ],
                    ),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext bc) {
                          return AlertDialog(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            title: const Text(
                              "HealthCare",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: const Wrap(
                              children: [
                                Text("Você sairá do aplicativo!"),
                                Text("Deseja realmente sair do aplicativo?")
                              ],
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Não")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const WelcomePage()));
                                  },
                                  child: const Text("Sim")),
                            ],
                          );
                        });
                  },
                )
              ],
            ),
          )),
    );
  }
}
