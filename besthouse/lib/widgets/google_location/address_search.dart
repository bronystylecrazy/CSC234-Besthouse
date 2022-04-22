import 'package:flutter/material.dart';
import '../../services/location_api.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  final sessionToken;
  late PlaceApiProvider apiClient;

  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) {
        List<Suggestion> suggestions = [];
        if (snapshot.hasData) {
          suggestions = snapshot.data as List<Suggestion>;
        }

        return query == ""
            ? Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text('Enter your address'),
              )
            : suggestions.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      title: Text(suggestions[index].description),
                      onTap: () {
                        close(context, suggestions[index]);
                      },
                    ),
                    itemCount: suggestions.length,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
      },
    );
  }
}
