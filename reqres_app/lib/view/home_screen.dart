import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:reqres_app/widgets/loadinglayer.dart';

import '../controller/participants_controller.dart';
import '../model/participant_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ParticipantController _participantController;
  late List<Participant> _participants;
  int _page = 1;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _participantController = ParticipantController();
    _participants = [];
    _loadParticipants();
  }

  Future<void> _loadParticipants() async {
    try {
      final participants =
          await _participantController.fetchParticipants(_page);
      setState(() {
        _participants.addAll(participants);
        isLoading = false;
      });
    } catch (error) {
      print('Failed to load participants: $error');
    }
  }

  Future<void> _changePage(int pageNumber) async {
    setState(() {
      isLoading = true;
      _page = pageNumber;
      _participants = [];
      _loadParticipants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Participants",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Text("List off all the participants of ReqRes."),
              ],
            ),
          ),
          !isLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 240,
                  child: _participants.isNotEmpty
                      ? SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _participants.length,
                            itemBuilder: (BuildContext context, int index) {
                              final participant = _participants[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(participant.avatar),
                                  ),
                                  title: Text(
                                      '${participant.firstName} ${participant.lastName}'),
                                  subtitle: Text(participant.email),
                                  onTap: () {},
                                ),
                              );
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "There is not any participants at page $_page :(",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height - 250,
                  child: LoadingLayer(),
                ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                3,
                (index) {
                  final pageNumber = index + 1;
                  return GestureDetector(
                    onTap: () {
                      _changePage(pageNumber);
                      print('Tapped on page $pageNumber');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _page == pageNumber
                              ? Colors.blue
                              : Colors.grey.shade400,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '$pageNumber',
                            style: TextStyle(
                              color: _page == pageNumber
                                  ? Colors.white
                                  : Colors.grey.shade900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
