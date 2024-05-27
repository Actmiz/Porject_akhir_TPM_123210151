import 'package:flutter/material.dart';
import 'package:project_akhir_tpm/models/valorant_model.dart';
import 'package:project_akhir_tpm/screen/valorant_weapon_detail_view.dart';
import 'package:project_akhir_tpm/services/valorant_api_service.dart';

class ValorantWeaponView extends StatefulWidget {
  @override
  _ValorantWeaponViewState createState() => _ValorantWeaponViewState();
}

class _ValorantWeaponViewState extends State<ValorantWeaponView> {
  late Future<List<ValorantWeapon>> _weaponsFuture;

  @override
  void initState() {
    super.initState();
    _loadWeapons();
  }

  Future<void> _loadWeapons() async {
    setState(() {
      _weaponsFuture = ValorantApiService().fetchValorantWeapons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ValorantWeapon>>(
        future: _weaponsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final weapons = snapshot.data!;
            return ListView.builder(
              itemCount: weapons.length,
              itemBuilder: (context, index) {
                final weapon = weapons[index];
                return ListTile(
                  title: Text(weapon.displayName,
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text(weapon.cleanedCategory,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 156, 151, 151))),
                  leading: Image.network(
                    weapon.displayIcon,
                    width: 200,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ValorantWeaponDetailView(weapon: weapon),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
