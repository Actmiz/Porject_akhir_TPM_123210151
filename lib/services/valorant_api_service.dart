import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/valorant_model.dart';

class ValorantApiService {
  Future<List<ValorantCharacter>> fetchValorantCharacters() async {
    final response = await http.get(
      Uri.parse('https://valorant-api.com/v1/agents'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final List<dynamic> charactersJson = responseBody['data'];

      if (charactersJson != null) {
        List<ValorantCharacter> filteredCharacters = charactersJson
            .map((json) => ValorantCharacter.fromJson(json))
            .where((character) =>
                character.uuid != 'ded3520f-4264-bfed-162d-b080e2abccf9')
            .toList();
        return filteredCharacters;
      } else {
        throw Exception('Failed to parse Valorant agents data');
      }
    } else {
      throw Exception('Failed to load Valorant agents');
    }
  }

  Future<List<ValorantMap>> fetchValorantMaps() async {
    final response = await http.get(
      Uri.parse('https://valorant-api.com/v1/maps'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final List<dynamic> mapsJson = responseBody['data'];

      if (mapsJson != null) {
        return mapsJson.map((json) => ValorantMap.fromJson(json)).toList();
      } else {
        throw Exception('Failed to parse Valorant maps data');
      }
    } else {
      throw Exception('Failed to load Valorant maps');
    }
  }

  Future<List<ValorantWeapon>> fetchValorantWeapons() async {
    final response = await http.get(
      Uri.parse('https://valorant-api.com/v1/weapons'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final List<dynamic> weaponsJson = responseBody['data'];

      if (weaponsJson != null) {
        return weaponsJson
            .map((json) => ValorantWeapon.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to parse Valorant weapons data');
      }
    } else {
      throw Exception('Failed to load Valorant weapons');
    }
  }

  Future<List<Tier>> fetchValorantCompetitiveTiers() async {
    final response = await http.get(
      Uri.parse('https://valorant-api.com/v1/competitivetiers'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final List<dynamic> tiersJson = responseBody['data'][0]['tiers'];

      if (tiersJson != null) {
        List<Tier> filteredTiers = tiersJson
            .map((json) => Tier.fromJson(json))
            .where((tier) =>
                tier.tierName != 'Unused1' && tier.tierName != 'Unused2')
            .toList();

        return filteredTiers;
      } else {
        throw Exception('Failed to parse competitive tiers data');
      }
    } else {
      throw Exception('Failed to load competitive tiers');
    }
  }
}
