import 'package:flutter/material.dart';
import 'package:health_app/providers/add_appointment_provider.dart';
import 'package:health_app/routes/routes_constants.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class SearchService extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.chevron_left));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<AddAppointmentProvider>(
        builder: (context, appointment, child) {
      appointment.searchList(query);
      return ListView.builder(
          itemCount: appointment.hints.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(appointment.hints[index]),
            );
          });
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<AddAppointmentProvider>(
        builder: (context, appointment, child) {
      appointment.searchList(query);

      return ListView.builder(
          itemCount: appointment.hints.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                appointment.searchResult(appointment.hints[index]);
                close(context, '');
                context.replaceNamed(RoutesConstants.addAppointment);
              },
              title: Text(appointment.hints[index]),
            );
          });
    });
  }
}
