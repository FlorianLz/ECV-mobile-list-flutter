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
  int _currentLoadedPage = 1;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    fetchData(_currentLoadedPage);
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 500) {
        _currentLoadedPage++;
        fetchData(_currentLoadedPage);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  void fetchData(int pageNumber) async {
    final result = await http.get(Uri.parse('https://rickandmortyapi.com/api/character?page=$pageNumber'));
    if(result.statusCode == 200){
      final json = jsonDecode(result.body);
      final List<dynamic> jsonCharacters = json['results'];
      setState(() {
        characters.addAll(jsonCharacters);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if(characters.isEmpty){
      content = const Center(child: CircularProgressIndicator());
    }else{
      content = ListView.builder(
        controller: _scrollController,
        itemCount: characters.length,
        itemBuilder: (BuildContext context, int index) { 
          dynamic character = characters[index];return InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CharacterDetailsPage(id: character['id'], imageUrl: character['image'])
            )),
            child: CharacterCard(
              imageUrl: character['image'],
              name: character['name']
            ),
        );
        },
        
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