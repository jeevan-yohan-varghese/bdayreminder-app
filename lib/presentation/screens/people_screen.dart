import 'package:bday_reminder_bloc/cubit/init/init_cubit.dart';
import 'package:bday_reminder_bloc/cubit/people/add_person_cubit.dart';
import 'package:bday_reminder_bloc/cubit/people/people_cubit.dart';
import 'package:bday_reminder_bloc/data/models/person.dart';
import 'package:bday_reminder_bloc/presentation/custom/people_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PeopleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PeopleState();
  }
}

class _PeopleState extends State<PeopleScreen> {
  String newPersonSelectedDate = "Select date";

  final TextEditingController _searchQuery = TextEditingController();
  bool _IsSearching = false;
  Icon actionIcon = const Icon(Icons.search, color: Colors.grey);
  Widget appBarTitle = const Text(
    "People",
    style: TextStyle(color: Colors.black),
  );

  _PeopleState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
        });
        BlocProvider.of<PeopleCubit>(context).filterList("");
      } else {
        setState(() {
          _IsSearching = true;
        });
        BlocProvider.of<PeopleCubit>(context).filterList(_searchQuery.text);
      }
    });
  }

  GlobalKey<ScaffoldMessengerState> _peopleScaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    //BlocProvider.of<PeopleCubit>(context).getPeople();

    return BlocListener<AddPersonCubit, AddPersonState>(
      listener: (context, state) {
        if (state is AddPersonSuccess) {
          Navigator.pop(context);
          BlocProvider.of<PeopleCubit>(context).getPeople();
          _peopleScaffoldKey.currentState
              ?.showSnackBar(SnackBar(content: Text("Person added")));
        }
      },
      child: ScaffoldMessenger(
        key: _peopleScaffoldKey,
        child: Scaffold(
          appBar: AppBar(
            title: appBarTitle,
            actions: [
              IconButton(
                icon: actionIcon,
                onPressed: () {
                  setState(() {
                    if (actionIcon.icon == Icons.search) {
                      actionIcon = const Icon(Icons.close, color: Colors.grey);
                      appBarTitle = TextField(
                        controller: _searchQuery,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          hintText: "Search name...",
                        ),
                      );
                      _handleSearchStart();
                    } else {
                      _handleSearchEnd();
                    }
                  });
                },
              ),
            ],
            backgroundColor: const Color(0xfffafafa),
          ),
          body: SafeArea(
            child: Column(
              children: [
                _getPeopleListWidget(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              BlocProvider.of<AddPersonCubit>(context)
                  .showDialog(isNew: true, id: null, name: null, dob: null);
              showAddPersonDialog(context, "NEW", null, null, null);
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      actionIcon = const Icon(
        Icons.search,
        color: Colors.grey,
      );
      appBarTitle = const Text(
        "People",
        style: TextStyle(color: Colors.black),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }

  Widget _getPeopleListWidget() {
    return BlocBuilder<PeopleCubit, PeopleState>(builder: (context, state) {
      if (state is PeopleSuccess) {
        List<Person> filteredList = state.filteredList;
        return filteredList.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, position) {
                      return InkWell(
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return SimpleDialog(
                                  title: Text(filteredList[position].name),
                                  children: [
                                    SimpleDialogOption(
                                      child: Text("Edit"),
                                      onPressed: () {
                                        BlocProvider.of<AddPersonCubit>(context)
                                            .showDialog(
                                                isNew: false,
                                                id: filteredList[position].id,
                                                name:
                                                    filteredList[position].name,
                                                dob:
                                                    filteredList[position].dob);
                                        showAddPersonDialog(
                                            context,
                                            "EDIT",
                                            filteredList[position].id,
                                            filteredList[position].name,
                                            filteredList[position].dob);
                                      },
                                    ),
                                    SimpleDialogOption(
                                      child: Text("Delete"),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: Text("Delete"),
                                                content: Text(
                                                    "Are you sure you want to delete ${filteredList[position].name}?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("No")),
                                                  TextButton(
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    PeopleCubit>(
                                                                context)
                                                            .deletePerson(
                                                                filteredList[
                                                                        position]
                                                                    .id);
                                                      },
                                                      child: Text("Yes")),
                                                ],
                                              );
                                            });
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                        child: PeopleListItem(
                            name: filteredList[position].name,
                            dob: filteredList[position].dob),
                      );
                    }))
            : state.isSearching
                ? Text("Not found")
                : Text("You haven't added anyone");
      }

      if (state is PeopleFailed) {
        return Text("some error occured : ${state.error}");
      }

      return Text("Loading people");
    });
  }

  /*------------------------Add person dialog-------------------- */
  void showAddPersonDialog(BuildContext context, String mode, String? id,
      String? name, String? dob) {
    /*

    Modes
    NEW : to create a new person
    EDIT: to edit existing person
    */

    bool _isNew = (mode == "NEW");

    newPersonSelectedDate = "Select Date";
    String personId = "";
    String dialogTitle = _isNew ? "Add person" : "Edit";

    final nameController = TextEditingController();

    if (!_isNew) {
      nameController.text = name ?? "";
      newPersonSelectedDate = dob ?? "Select date";
      personId = id ?? "";
      BlocProvider.of<AddPersonCubit>(context)
          .setSelectedDate(newPersonSelectedDate);
    }
    showDialog(
        context: context,
        builder: (_) {
          return BlocProvider<AddPersonCubit>.value(
            value: BlocProvider.of(context),
            child: BlocBuilder<AddPersonCubit, AddPersonState>(
              builder: (context, state) {
                if (state is AddPersonDialogState) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xfffafafa)),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            dialogTitle,
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          const Text("Date of birth "),
                          TextButton(
                            onPressed: () {
                              _showDatePicker(context);
                            },
                            child: Text(state.date,
                                style: const TextStyle(color: Colors.black)),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (nameController.text.trim().isNotEmpty &&
                                    state.date != "" &&
                                    state.date != "Select date") {
                                  if (_isNew) {
                                    BlocProvider.of<AddPersonCubit>(context)
                                        .addPerson(
                                            nameController.text, state.date);

                                    //pop dialog
                                  } else {
                                    //call edit new person api
                                    //pop dialog
                                    BlocProvider.of<AddPersonCubit>(context)
                                        .editPerson(personId,
                                            nameController.text, state.date);
                                  }
                                }
                              },
                              child: _isNew
                                  ? const Text("Add")
                                  : const Text("Update"))
                        ],
                      ),
                    ),
                  );
                }

                return Text("Loading");
              },
            ),
          );
        });
  }

  Future<void> _showDatePicker(dContext) async {
    final DateTime? picked = await showDatePicker(
        context: dContext,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null) {
      String formattedDate = DateFormat("yyyy-MM-dd").format(picked);

      // setState(() {
      //   newPersonSelectedDate = formattedDate;
      // });
      BlocProvider.of<AddPersonCubit>(context).setSelectedDate(formattedDate);
    }
  }

  void showSnackbar(String message) {}
}
