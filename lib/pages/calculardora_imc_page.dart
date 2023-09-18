import 'package:flutter/material.dart';
import 'package:healthcare/components/alert_dialog.dart';
import 'package:healthcare/models/pessoa.dart';
import 'package:healthcare/pages/detalhes_imc_page.dart';
import 'package:healthcare/repositories/calculo_imc_repository.dart';

class CalculadoraImcPage extends StatefulWidget {
  const CalculadoraImcPage({super.key});

  @override
  State<CalculadoraImcPage> createState() => _CalculadoraImcPageState();
}

class _CalculadoraImcPageState extends State<CalculadoraImcPage> {
  var nomeController = TextEditingController();
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();
  var _pessoas = <Pessoa>[];

  var calculoImcRepository = CalculoImcRepository();

  void obterCalculos() async {
    _pessoas = await calculoImcRepository.listarPessoas();
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
        backgroundColor: Colors.lightBlue,
        title: const Text("Calculadora IMC"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text(
                      "Preencha os campos abaixo",
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
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Salvar'),
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
                          calculoImcRepository.adicionar(Pessoa(
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
                : ListView.builder(
                    itemCount: _pessoas.length,
                    itemBuilder: (BuildContext bc, int index) {
                      var pessoa = _pessoas[index];
                      return Dismissible(
                          onDismissed:
                              (DismissDirection dismissdirection) async {
                            await calculoImcRepository.remove(pessoa.id);
                            obterCalculos();
                          },
                          key: Key(pessoa.id),
                          child: ListTile(
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
                                  await calculoImcRepository.remove(pessoa.id);
                                  obterCalculos();
                                }
                              },
                              itemBuilder: (BuildContext bc) {
                                return <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                      value: "seemore",
                                      child: Text("Ver detalhes")),
                                  const PopupMenuItem<String>(
                                      value: "delete", child: Text("Excluir")),
                                ];
                              },
                            ),
                          ));
                    },
                  ),
          )
        ],
      ),
    );
  }
}
