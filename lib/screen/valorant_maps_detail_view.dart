import 'package:flutter/material.dart';
import 'package:project_akhir_tpm/models/valorant_model.dart'; // Sesuaikan dengan path model Anda

class ValorantMapsDetailView extends StatelessWidget {
  final ValorantMap map;

  const ValorantMapsDetailView({Key? key, required this.map}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(map.displayName),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Image.network(
              map.displayIcon,
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              "ID: ${map.uuid}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
