import 'package:flutter/material.dart';
import 'package:schedorganizer/common.dart';
import 'package:schedorganizer/helpers/ui.dart';
import 'package:schedorganizer/models/apires.dart';
import 'package:schedorganizer/models/subject.dart';
import 'package:schedorganizer/widgets/loading.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key, required this.id});

  final int id;

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  late Future<ApiRes<Subject>> futureSubject;

  String subjectShortName = "Loading subject...";

  @override
  void initState() {
    super.initState();
    futureSubject = api.getSubjectById(widget.id);
    futureSubject.then((value) {
      setState(() {
        subjectShortName = value.data.shortName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(subjectShortName),
      ),
      body: FutureBuilder<ApiRes<Subject>>(
        future: futureSubject,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.data;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    data.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Group: ${data.group}"),
                  FilledButton.icon(
                    onPressed: () {
                      if (data.url == null || data.url == "") {
                        UI.snackbar(
                          context,
                          "This subject does not have a URL",
                        );
                        return;
                      }

                      UI.openUrl(data.url!);
                    },
                    icon: const Icon(Icons.link),
                    label: const Text("URL"),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: data.rooms.length,
                        itemBuilder: (context, index) {
                          final room = data.rooms[index];
                          return UI.card(
                            Text("Room ${room.location}"),
                            Text(room.description),
                            const Icon(Icons.room)
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const LoadingWidget();
        },
      ),
    );
  }
}
