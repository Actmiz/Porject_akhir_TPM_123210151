import 'package:flutter/material.dart';
import '../models/valorant_model.dart';

class ValorantWeaponDetailView extends StatelessWidget {
  final ValorantWeapon weapon;

  const ValorantWeaponDetailView({Key? key, required this.weapon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weapon Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${weapon.displayName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Category: ${weapon.cleanedCategory}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Image.network(
              weapon.displayIcon,
              width: 400, // Atur lebar gambar sesuai kebutuhan
              height: 100, // Atur tinggi gambar sesuai kebutuhan
              fit: BoxFit.cover, // Atur metode penyesuaian gambar
            ),
            Expanded(
              child: ListView(
                children: weapon.weaponStats?.damageRanges.map((damageRange) {
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Range Start Meters: ${damageRange.rangeStartMeters}',
                                style: TextStyle(color: Colors.white)),
                            Text(
                                'Range End Meters: ${damageRange.rangeEndMeters}',
                                style: TextStyle(color: Colors.white)),
                            Text('Head Damage: ${damageRange.headDamage}',
                                style: TextStyle(color: Colors.white)),
                            Text('Body Damage: ${damageRange.bodyDamage}',
                                style: TextStyle(color: Colors.white)),
                            Text('Leg Damage: ${damageRange.legDamage}',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        // Anda bisa mengakses properti lain dari damageRange dengan cara yang sama
                      );
                    }).toList() ??
                    [],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Skins:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: weapon.skins.length,
                itemBuilder: (context, index) {
                  final skin = weapon.skins[index];

                  if (skin.displayIcon.isNotEmpty) {
                    return ListTile(
                      title: Text(
                        skin.displayName,
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: Image.network(
                        skin.displayIcon,
                        width: 200,
                        height: 100,
                      ),
                    );
                  } else {
                    return SizedBox(); // Placeholder widget
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
