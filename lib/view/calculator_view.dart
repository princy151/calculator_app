import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  final _key = GlobalKey<FormState>();
  String input = "";
  String? miniDisplay;
  double? firstOperand;
  double? secondOperand;
  String? operator;

  void _calculate() {
    if (firstOperand != null && secondOperand != null && operator != null) {
      double result;
      switch (operator) {
        case "+":
          result = firstOperand! + secondOperand!;
          break;
        case "-":
          result = firstOperand! - secondOperand!;
          break;
        case "*":
          result = firstOperand! * secondOperand!;
          break;
        case "/":
          result = secondOperand != 0 ? firstOperand! / secondOperand! : 0;
          break;
        case "%":
          result = firstOperand! % secondOperand!;
          break;
        default:
          result = 0;
      }
      _textController.text = result.toString();
      input = result.toString();
      miniDisplay = null;
      firstOperand = null;
      secondOperand = null;
      operator = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adarsh Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              if (miniDisplay !=
                  null) // Show the smaller display only when needed
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    miniDisplay!,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: lstSymbols.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        String symbol = lstSymbols[index];
                        setState(() {
                          switch (symbol) {
                            case "C":
                              _textController.text = "";
                              input = "";
                              miniDisplay = null;
                              firstOperand = null;
                              secondOperand = null;
                              operator = null;
                              break;
                            case "<-":
                              if (input.isNotEmpty) {
                                input = input.substring(0, input.length - 1);
                                _textController.text = input;
                              }
                              break;
                            case "+":
                            case "-":
                            case "*":
                            case "/":
                            case "%":
                              if (firstOperand == null && input.isNotEmpty) {
                                firstOperand = double.tryParse(input);
                                operator = symbol;
                                miniDisplay =
                                    "$firstOperand $operator"; // Update mini display
                                input = "";
                                _textController.text = input;
                              }
                              break;
                            case "=":
                              if (firstOperand != null && input.isNotEmpty) {
                                secondOperand = double.tryParse(input);
                                _calculate();
                              }
                              break;
                            default:
                              input += symbol;
                              _textController.text = input;
                          }
                        });
                      },
                      child: Text(
                        lstSymbols[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
