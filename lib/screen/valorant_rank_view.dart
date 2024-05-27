import 'package:flutter/material.dart';
import '../models/valorant_model.dart';
import '../services/valorant_api_service.dart';

class ValorantRankView extends StatefulWidget {
  @override
  _ValorantRankViewState createState() => _ValorantRankViewState();
}

class _ValorantRankViewState extends State<ValorantRankView> {
  late Future<List<Tier>> _futureCompetitiveTiers;

  @override
  void initState() {
    super.initState();
    _futureCompetitiveTiers =
        ValorantApiService().fetchValorantCompetitiveTiers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Tier>>(
        future: _futureCompetitiveTiers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final tier = snapshot.data![index];
                return ListTile(
                  title: Text(tier.tierName,
                      style: TextStyle(color: Colors.white)),
                  leading: Image.network(
                    tier.smallIcon,
                    height: 50,
                    width: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error);
                    },
                  ),
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
