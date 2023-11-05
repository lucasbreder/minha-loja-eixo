import 'package:flutter/material.dart';

class NumberTotal extends StatelessWidget {
  const NumberTotal(
      {required this.title,
      required this.value,
      this.color = const Color.fromARGB(255, 35, 180, 115),
      super.key});

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                width: 3,
                color: color,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              top: 15.0,
            ),
            child: Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(value.substring(0, 2),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color,
                      )),
                ),
                Text(
                  value.substring(2),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
