import 'package:flutter/material.dart';
import 'package:healthcare/components/alert_dialog.dart';
import 'package:healthcare/components/custom_drawer.dart';
import 'package:healthcare/models/configuracoes_model.dart';
import 'package:healthcare/models/pessoa.dart';
import 'package:healthcare/pages/detalhes_imc_page.dart';
import 'package:healthcare/pages/notificacoes_page.dart';
import 'package:healthcare/repositories/configuracoes_repository.dart';
import 'package:healthcare/repositories/sqlite/calculo_imc_sql_repository.dart';

class CalculadoraImcPage extends StatefulWidget {
  const CalculadoraImcPage({super.key});

  @override
  State<CalculadoraImcPage> createState() => _CalculadoraImcPageState();
}

class _CalculadoraImcPageState extends State<CalculadoraImcPage> {
  late ConfiguracoesRepository configuracoesRepository;
  var configuracoesModel = ConfiguracoesModel.vazio();
  var nomeController = TextEditingController();
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();
  double toolbarHeight = 100;
  bool autoPreencher = true;
  var _pessoas = <Pessoa>[];
  CalculoIMCSQliteRepository calculoImcRepository =
      CalculoIMCSQliteRepository();

  void obterCalculos() async {
    _pessoas = await calculoImcRepository.obterDados();
    setState(() {});
  }

  void carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoesRepository.obterDados();
    nomeController.text = configuracoesModel.nomeUsuario;
    alturaController.text = configuracoesModel.altura.toString();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    obterCalculos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            color: Colors.white,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
            style: const ButtonStyle(
                shadowColor: MaterialStatePropertyAll(Colors.white)),
          );
        }),
        actions: [
          Container(
              padding: const EdgeInsets.all(20),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificacoesPage()));
                  });
                },
                icon: const Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.blueAccent,
                ),
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
              ))
        ],
        toolbarHeight: toolbarHeight,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Image.asset(
          "lib/assets/images/_logo.png",
          height: 150,
          color: Colors.white,
        ),
      ),
      drawer: const CustomDrawer(),
      floatingActionButton: FloatingActionButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text(
                      "Calculadora IMC",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    content: SizedBox(
                      width: 600,
                      child: ListView(
                        children: [
                          const Text("Nome"),
                          TextField(
                            keyboardType: TextInputType.name,
                            controller: nomeController,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text("Peso"),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: pesoController,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text("Altura"),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: alturaController,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Preencher'),
                        onPressed: () {
                          carregarDados();
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Calcular'),
                        onPressed: () {
                          if (nomeController.text.trim().isEmpty) {
                            CustomDialog.show(context, "Digite o nome");
                            return;
                          }
                          if (pesoController.text.trim().isEmpty) {
                            showDialog(
                                context: context,
                                builder: (BuildContext bc) {
                                  return AlertDialog(
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                      title: const Text("Digite o peso!"));
                                });
                            return;
                          }
                          if (alturaController.text.trim().isEmpty) {
                            showDialog(
                                context: context,
                                builder: (BuildContext bc) {
                                  return AlertDialog(
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                      title: const Text("Digite a altura!"));
                                });
                            return;
                          }
                          calculoImcRepository.salvar(Pessoa(
                              0,
                              nomeController.text,
                              double.parse(
                                  pesoController.text.replaceAll(",", ".")),
                              double.parse(
                                  alturaController.text.replaceAll(",", "."))));
                          Navigator.pop(context);
                          nomeController.text = "";
                          pesoController.text = "";
                          alturaController.text = "";
                          obterCalculos();
                        },
                      ),
                    ],
                  );
                });
          },
          child: const Icon(Icons.calculate)),
      body: Column(
        children: [
          Expanded(
            child: _pessoas.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                        alignment: Alignment.bottomLeft,
                        child: const Row(
                          children: [
                            Text("Clique no botão para calcular"),
                            SizedBox(width: 15),
                            Icon(Icons.arrow_forward)
                          ],
                        )),
                  )
                : Padding(
                    padding: const EdgeInsets.all(4),
                    child: ListView.builder(
                      itemCount: _pessoas.length,
                      itemBuilder: (BuildContext bc, int index) {
                        var pessoa = _pessoas[index];
                        return Dismissible(
                            background: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              margin: const EdgeInsets.all(5),
                              color: Colors.red[300],
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Excluir",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Excluir",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onDismissed:
                                (DismissDirection dismissdirection) async {
                              await calculoImcRepository.remover(pessoa.id);
                              obterCalculos();
                            },
                            key: Key(pessoa.id.toString()),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              color: Colors.blue[50],
                              margin: const EdgeInsets.all(5),
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                isThreeLine: true,
                                title: Text(pessoa.nome),
                                subtitle: Row(
                                  children: [
                                    Text(
                                        "IMC: ${pessoa.retornaIMC().toStringAsFixed(2)} |  Altura: ${pessoa.altura.toStringAsFixed(2)} \nPeso: ${pessoa.peso} |  Situação: ${pessoa.retornaResultadoIMC()}"),
                                  ],
                                ),
                                trailing: PopupMenuButton<String>(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onSelected: (menu) async {
                                    if (menu == "seemore") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetalhesIMC(pessoa: pessoa)));
                                    }
                                    if (menu == "delete") {
                                      await calculoImcRepository
                                          .remover(pessoa.id);
                                      obterCalculos();
                                    }
                                  },
                                  itemBuilder: (BuildContext bc) {
                                    return <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                          value: "seemore",
                                          child: Text("Ver detalhes")),
                                      const PopupMenuItem<String>(
                                          value: "delete",
                                          child: Text("Excluir")),
                                    ];
                                  },
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
