import 'package:flutter/material.dart';
import 'package:project_akhir_tpm/screen/valorant_character_detail_view.dart';
import '../services/valorant_api_service.dart';
import '../models/valorant_model.dart';

class ValorantCharacterView extends StatefulWidget {
  @override
  _ValorantCharacterViewState createState() => _ValorantCharacterViewState();
}

class _ValorantCharacterViewState extends State<ValorantCharacterView> {
  final ValorantApiService apiService = ValorantApiService();
  List<ValorantCharacter> characters = [];
  bool isLoading = false;
  bool isPlayableCharacter = true;

  @override
  void initState() {
    super.initState();
    fetchValorantCharacters();
  }

  void fetchValorantCharacters() async {
    setState(() {
      isLoading = true;
    });

    try {
      final charactersData = await apiService.fetchValorantCharacters();
      setState(() {
        characters = charactersData;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: characters.map((character) {
                    final isValidUrl = Uri.tryParse(character.displayIconSmall)
                            ?.hasAbsolutePath ??
                        false;
                    return ListTile(
                      title: Text(character.displayName,
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text("ID: ${character.uuid}",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 196, 182, 182))),
                      leading: isValidUrl
                          ? Image.network(
                              character.displayIconSmall,
                              width: 50,
                              height: 50,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.error),
                            )
                          : Icon(Icons.image_not_supported),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      // Optional: Menambahkan onTap untuk interaksi
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CharacterDetailScreen(
                                uuid: character.uuid, characters: characters),
                          ),
                        );

                        // Tampilkan notifikasi jika karakter tidak ditemukan
                        if (result != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result.toString())),
                          );
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
      ),
    );
  }
}
