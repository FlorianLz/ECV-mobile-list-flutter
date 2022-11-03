import 'dart:convert';

import 'package:ecv_mobile_list_flutter/character_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'character_details.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  List<dynamic> characters = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  void fetchData() async {
    final result = await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));
    final json = jsonDecode(result.body);
    final List<dynamic> jsonCharacters = json['results'];
    setState(() {
      characters = jsonCharacters;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if(characters.isEmpty){
      content = const Center(child: CircularProgressIndicator());
    }else{
      content = ListView(
        children: 
          characters.map((character) => InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CharacterDetailsPage(id: character['id'])
            )),
            child: CharacterCard(
              imageUrl: character['image'],
              name: character['name']
            ),
          )).toList()
        
      );
    }
    return Scaffold( 
      appBar: AppBar(
        title: const Text('Personnages')
      ),
      body: content,
    );
  }
}