import 'package:flutter/material.dart';
import 'package:project_akhir_tpm/models/valorant_model.dart'; // Sesuaikan dengan path model Anda
import 'package:project_akhir_tpm/screen/valorant_maps_detail_view.dart';
import 'package:project_akhir_tpm/services/valorant_api_service.dart'; // Sesuaikan dengan path service Anda

class ValorantMapsView extends StatefulWidget {
  @override
  _ValorantMapsViewState createState() => _ValorantMapsViewState();
}

class _ValorantMapsViewState extends State<ValorantMapsView> {
  late Future<List<ValorantMap>> _mapsFuture;

  @override
  void initState() {
    super.initState();
    _loadMaps();
  }

  Future<void> _loadMaps() async {
    setState(() {
      _mapsFuture = ValorantApiService().fetchValorantMaps();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ValorantMap>>(
        future: _mapsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final map = snapshot.data![index];
                return ListTile(
                    title: Text(map.displayName,
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text("           ",
                        style: TextStyle(color: Colors.white)),
                    leading: Image.network(map.listViewIcon),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ValorantMapsDetailView(map: map),
                        ),
                      );
                    });
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
