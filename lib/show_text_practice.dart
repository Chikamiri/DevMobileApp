import 'package:flutter/material.dart';

class ShowTextPractice extends StatelessWidget {
  const ShowTextPractice({super.key});

  @override
  // Widget build(BuildContext context) {
  //   return Text("Henlo", maxLines: 4,
  //   textAlign: TextAlign.center,
  //   softWrap: true,
  //   overflow: TextOverflow.ellipsis,
  //   style: TextStyle(
  //     color: Colors.amber,
  //     backgroundColor: Colors.brown,
  //     fontWeight: FontWeight.bold,
  //     fontSize: 55,
  //     decoration: TextDecoration.underline,
  //   ));
  // }
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          // TextSpan(
          //   text: "Rule",
          //   style: TextStyle(color: Colors.greenAccent, fontSize: 36),
          // ),
          // TextSpan(
          //   text: "34",
          //   style: TextStyle(color: Colors.greenAccent, fontSize: 63),
          // ),
          TextSpan(
            text:
                "\nNgoài ra còn có các lệnh khác cầu kỳ hơn phải vào menu để trình bày như: ",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          TextSpan(
            text: " Words Only ",
            style: const TextStyle(
              color: Colors.black,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
          TextSpan(
            text: "chỉ ",
            style: const TextStyle(color: Colors.black),
          ),

          TextSpan(
            children: "gạch dưới cho từng chữ một. "
                .split(' ')
                .map(
                  (word) => TextSpan(
                    text: '$word ',
                    style: const TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.wavy,
                    ),
                  ),
                )
                .toList(),
          ),

          TextSpan(
            text: "Double ",
            style: const TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: "để gạch dưới hai nét. ",
            style: const TextStyle(
              color: Colors.black,

              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.double,
            ),
          ),
          TextSpan(
            text: "Dotted ",
            style: const TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: "để gạch dưới bằng dấu chấm, ",
            style: const TextStyle(
              color: Colors.black,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dotted,
            ),
          ),
          TextSpan(
            text: "Strikethrough ",
            style: const TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: "tạo ra chữ gạch giữa",
            style: const TextStyle(
              color: Colors.black,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const TextSpan(
            text: ", các lệnh ",
            style: TextStyle(color: Colors.black),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Transform.translate(
              offset: Offset(0, -3),
              child: Text(
                "Superscript ",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),

          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Transform.translate(
              offset: Offset(0, 3),
              child: Text(
                "Subscript",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),

          const TextSpan(
            text: " giúp chúng ta tạo được một biểu thức đơn giản.",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
