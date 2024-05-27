import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../models/valorant_model.dart';

class CharacterDetailScreen extends StatelessWidget {
  final String uuid;
  final List<ValorantCharacter> characters;

  const CharacterDetailScreen({
    Key? key,
    required this.uuid,
    required this.characters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValorantCharacter? character = characters.firstWhereOrNull(
      (character) => character.uuid == uuid,
    );

    if (character == null) {
      // Jika karakter tidak ditemukan, kembali ke layar sebelumnya
      Navigator.pop(context, 'Character not found');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(character!.displayName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Foto karakter di sebelah kiri
                Image.network(
                  character.fullPortrait,
                  width: 200, // Atur lebar gambar sesuai kebutuhan
                  height: 200, // Atur tinggi gambar sesuai kebutuhan
                  fit: BoxFit.cover, // Atur metode penyesuaian gambar
                ),
                SizedBox(
                    width: 10), // Jarak antara foto karakter dan logo peran
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo peran di bagian atas
                    Image.network(
                      character.role.displayIcon,
                      width: 50, // Atur lebar logo peran sesuai kebutuhan
                      height: 50, // Atur tinggi logo peran sesuai kebutuhan
                      fit: BoxFit.cover, // Atur metode penyesuaian logo peran
                    ),
                    SizedBox(
                        height: 20), // Jarak antara logo peran dan nama peran
                    // Nama peran di bagian bawah
                    Text(
                      character.role.displayName,
                      style: TextStyle(
                        fontSize: 16, // Atur ukuran teks sesuai kebutuhan
                        fontWeight:
                            FontWeight.bold, // Atur gaya teks sesuai kebutuhan
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text("ID: ${character.uuid}"),
            SizedBox(height: 10),
            Text("Description: ${character.description}"),
            Text(
              "Abilities:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // ListView untuk menampilkan daftar abilities
            Expanded(
                child: ListView.builder(
                    itemCount: character.abilities.length,
                    itemBuilder: (context, index) {
                      final ability = character.abilities[index];
                      return ListTile(
                        title: Text(ability.displayName,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(ability.description,
                            style: TextStyle(color: Colors.white)),
                        leading: Image.network(
                          ability.displayIcon,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
