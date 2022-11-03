import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  const CharacterCard({super.key, required this.imageUrl, required this.name});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Image.network(
            imageUrl, 
            width: 120), 
             Flexible(
               child: Padding(
                padding: const EdgeInsets.only(left: 16), 
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 18)
                  )
                ),
             )
        ]),
      ),
    );
  }
  
}