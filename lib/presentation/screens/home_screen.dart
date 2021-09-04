import 'package:bday_reminder_bloc/cubit/home/born_today_cubit.dart';
import 'package:bday_reminder_bloc/cubit/home/upcoming_cubit.dart';
import 'package:bday_reminder_bloc/data/models/person.dart';
import 'package:bday_reminder_bloc/presentation/custom/bday_card.dart';
import 'package:bday_reminder_bloc/presentation/custom/people_list_item.dart';
import 'package:bday_reminder_bloc/utils/constants.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  final _currentPageNotifier = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UpcomingCubit>(context).loadUpcomingList();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                    image: AssetImage('assets/party.png'),
                    height: 50,
                    width: 50),
              ],
            ),
            _getTodaysBdayCards(),
            


            /*-----------------------------------Upcoming UI----------------------*/

            Container(
              padding: EdgeInsets.only(left: 20.0),
              margin: EdgeInsets.only(top: 24.0, bottom: 12.0),
              child: Row(
                children: [
                  Text("Upcoming", style: Theme
                      .of(context)
                      .textTheme
                      .headline5,)
                ],
              ),
            ),

            _getUpcomingList(),

          ],
        ),
      ),
    );
  }

  //Born Today Cards

  Widget _getTodaysBdayCards() {
    
    return BlocBuilder<BornTodayCubit, BornTodayState>(
      builder: (context, state) {
        if (state is BornTodaySuccess) {
          debugPrint("State : $state");
          debugPrint("peopleList length: ${state.peopleList.length}");
          List<Person> bornTodayList = state.peopleList;
          return Column(
            children: [
              bornTodayList.isNotEmpty? ExpandablePageView.builder(
                itemBuilder: (itemContext, position) {
                  return BdayCard(name: bornTodayList[position].name);
                },
                onPageChanged: (currentPageIndex) {
                  _currentPageNotifier.value = currentPageIndex;
                },
                itemCount: bornTodayList.length, // Can be null
              ):Text("No birthdays today"),


              CirclePageIndicator(
                  currentPageNotifier: _currentPageNotifier,
                  itemCount: state.peopleList.length,
                  size: 6.0,
                  selectedSize: 8.0,
                  selectedDotColor: Theme
                      .of(context)
                      .colorScheme
                      .secondary,
                  dotColor: COLOR_GREY,
                ),
            ],
          );
        }

        if (state is BornTodayFailure) {
          return Text("Some error occured");
        }

        return Text("Loading upcoming birthdays");
      },
    );
  }

  //Upcoming birthdays list
  Widget _getUpcomingList() {
    return BlocBuilder<UpcomingCubit, UpcomingState>(
      builder: (context, state) {
        if (state is UpcomingSucces) {
          return Flexible(
            child: ListView.builder(
              itemBuilder: (context, position) {
                return PeopleListItem(
                    name: state.upcomingList[position].name,
                    dob: state.upcomingList[position].dob);
              },

              itemCount: state.upcomingList.length, // Can be null
            ),
          );
        }

        if (state is UpcomingFailed) {
          return Text("Some error occured ${state.error}");
        }

        return Text("Loading");
      },
    );
  }
}
