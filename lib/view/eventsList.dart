import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:thedipaar/modal/eventsListModal.dart';
import 'package:thedipaar/service/web_service.dart';
import 'package:thedipaar/utils/appBarUtils.dart';
import 'package:thedipaar/utils/shareUtils.dart';
import 'package:thedipaar/utils/sideDrawer.dart';
import 'package:thedipaar/view/eventsDetail.dart';

class Event {
  final String id;
  final String title;
  final String imageUrl;
  final DateTime start;
  final DateTime end;
  final String? gmap;
  final String discription;

  Event(this.id, this.title, this.imageUrl, this.start, this.end, this.gmap,
      this.discription);

  @override
  String toString() =>
      '$title\n$imageUrl\n${start.toLocal()} - ${end.toLocal()}';
}

class TableEventsExample extends StatefulWidget {
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<EventsList> _events = [];
  bool isLoading = false;
  bool _isExpanded = false;
   String? shareBaseURL;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
    _getconfig();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier([]);
  }

   _getconfig()async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {
       shareBaseURL = prefs.getString('share_baseurl');
   });
  }

  Future<void> _fetchEvents() async {
    setState(() {
      isLoading = true;
    });
    try {
      final events = await webservice.fetchEventList();
      setState(() {
        _events = events;
        _selectedEvents.value = _getEventsForMonth(_focusedDay);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error
      print('Error: $e');
    }
  }

  List<Event> _getEventsForMonth(DateTime month) {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth =
        DateTime(month.year, month.month + 1, 0).add(const Duration(days: 1));
    return _events
        .where((event) =>
            event.startDate.isAfter(startOfMonth) &&
            event.startDate.isBefore(endOfMonth))
        .map((event) => Event(event.id, event.heading, event.heroImage,
            event.startDate, event.endDate, event.gmap, event.metaDescription))
        .toList();
  }

  void _updateSelectedEvents() {
    if (_selectedDay != null) {
      setState(() {
        if (_calendarFormat == CalendarFormat.month) {
          _selectedEvents.value = _getEventsForMonth(_selectedDay!);
        } else if (_calendarFormat == CalendarFormat.twoWeeks) {
          _selectedEvents.value = _getEventsForTwoWeeks(_selectedDay!);
        } else if (_calendarFormat == CalendarFormat.week) {
          _selectedEvents.value = _getEventsForWeek(_selectedDay!);
        }
      });
    }
  }

  List<Event> _getEventsForSelectedDay(DateTime day) {
    return _events
        .where((event) =>
            event.startDate.year == day.year &&
            event.startDate.month == day.month &&
            event.startDate.day == day.day)
        .map((event) => Event(event.id, event.heading, event.heroImage,
            event.startDate, event.endDate, event.gmap, event.metaDescription))
        .toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
   
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedEvents.value = _getEventsForSelectedDay(selectedDay);
    });
  }

  void _onFormatChanged(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
      _updateSelectedEvents();
    });
  }

  List<Event> _getEventsForCurrentFormat(DateTime? day) {
    if (day != null) {
      switch (_calendarFormat) {
        case CalendarFormat.month:
          return _getEventsForMonth(day);
        case CalendarFormat.twoWeeks:
          return _getEventsForTwoWeeks(day) ?? [];
        case CalendarFormat.week:
          return _getEventsForWeek(day) ?? [];
        default:
          return [];
      }
    }
    return [];
  }

  List<Event> _getEventsForWeek(DateTime day) {
    final startOfWeek = day.subtract(Duration(days: day.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    return _events
        .where((event) =>
            event.startDate.isAfter(startOfWeek) &&
            event.startDate.isBefore(endOfWeek))
        .map((event) => Event(event.id, event.heading, event.heroImage,
            event.startDate, event.endDate, event.gmap, event.metaDescription))
        .toList();
  }

  List<Event> _getEventsForTwoWeeks(DateTime day) {
    final startOfTwoWeeks = day.subtract(Duration(days: day.weekday - 1));
    final endOfTwoWeeks = startOfTwoWeeks.add(const Duration(days: 14));
    return _events
        .where((event) =>
            event.startDate.isAfter(startOfTwoWeeks) &&
            event.startDate.isBefore(endOfTwoWeeks))
        .map((event) => Event(event.id, event.heading, event.heroImage,
            event.startDate, event.endDate, event.gmap, event.metaDescription))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      drawer: MyDrawer(),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: _isExpanded
                    ? const Color(0xFFE93314)
                    : const Color(0xff23527C),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: const Offset(0, 10), // changes the shadow position
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.event,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Events calender view',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    _isExpanded
                        ? const Icon(
                            Icons.arrow_drop_up,
                            color: Colors.white,
                            size: 30,
                          )
                        : const Icon(Icons.arrow_drop_down_sharp,//arrow_drop_down_sharp
                            color: Colors.white, size: 30)
                  ],
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInQuart,
            child: _isExpanded
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 4,
                          blurRadius: 7,
                          offset: const Offset(
                              0, 10), // changes the shadow position
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      child: TableCalendar<Event>(
                        firstDay: DateTime(2024, 1, 1),
                        lastDay: DateTime(2024, 12, 31),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        calendarFormat: _calendarFormat,
                        eventLoader: _getEventsForCurrentFormat,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        headerStyle: HeaderStyle(
                          headerPadding:
                              const EdgeInsets.symmetric(vertical: 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFFE93314),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          titleTextStyle: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                          formatButtonTextStyle: const TextStyle(
                              fontSize: 16.0, color: Colors.white),
                          formatButtonDecoration: BoxDecoration(
                            color: const Color(0xff23527C),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        daysOfWeekHeight: 30,
                        rowHeight: 35,
                        calendarStyle: CalendarStyle(
                            outsideDaysVisible: false,
                            defaultTextStyle:
                                const TextStyle(color: Colors.black),
                            defaultDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              border:
                                  Border.all(color: const Color(0xff23527C)),
                            ),
                            weekendDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              border:
                                  Border.all(color: const Color(0xff23527C)),
                            ),
                            tableBorder: const TableBorder(
                              top: BorderSide(
                                  color: Color(0xFFE93314),
                                  width: 2.0,
                                  style: BorderStyle.solid),
                              left: BorderSide(
                                  color: Color(0xFFE93314),
                                  width: 2.0,
                                  style: BorderStyle.solid),
                              right: BorderSide(
                                  color: Color(0xFFE93314),
                                  width: 2.0,
                                  style: BorderStyle.solid),
                              bottom: BorderSide(
                                  color: Color(0xFFE93314),
                                  width: 2.0,
                                  style: BorderStyle.solid),
                              horizontalInside: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                                style: BorderStyle.solid,
                              ),
                              verticalInside: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            todayDecoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.rectangle,
                            ),
                            selectedDecoration: const BoxDecoration(
                                color: Color(0xFFE93314),
                                shape: BoxShape.circle),
                            markerDecoration:
                                const BoxDecoration(color: Color(0xff23527C))),
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, date, events) {
                            return _buildMarker(context, date, events);
                          },
                        ),
                        onDaySelected: _onDaySelected,
                        onFormatChanged: _onFormatChanged,
                        onPageChanged: (focusedDay) {
                          setState(() {
                            _focusedDay = focusedDay;
                            _selectedDay = focusedDay;
                          });
                          _updateSelectedEvents();
                        },
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Upcoming events: ',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18))),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  if (value.isEmpty) {
                    return const Center(
                      child: Text(
                        'No events available for the selected period.',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return eventsView(value[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget eventsView(Event event) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventsDetailScreen(
                      id: "${event.id}",
                      map:
                          "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2878.6650157312706!2d-79.2465154359007!3d43.82130736235018!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89d4d6d60b8fd115%3A0x89b775719080eb09!2s2761%20Markham%20Rd%20C26%2C%20Scarborough%2C%20ON%20M1X%200A4%2C%20Canada!5e0!3m2!1sen!2sin!4v1576963762059!5m2!1sen!2sin",
                    )));
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            // height: 380,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Card(
              color: const Color(0xff23527C),
              shadowColor: const Color(0xFFE93314),
              surfaceTintColor: const Color(0xff23527C),
              elevation: 5.0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        "http://52.77.122.228/uploads/events/${event.imageUrl}",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.network(
                            'https://www.shutterstock.com/image-photo/concept-image-business-acronym-eod-260nw-332349266.jpg',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Text(
                        event.title,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Text(
                        event.discription,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                                size: 14,
                              ),
                              Text(
                                  'Start Date: ${DateFormat('dd-MM-yyyy').format(event.start)}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                                size: 14,
                              ),
                              Text(
                                  'End Date: ${DateFormat('dd-MM-yyyy').format(event.end)}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            right: MediaQuery.of(context).size.width * 0.06,
            child: GestureDetector(
              onTap: () async {
                await ShareUtils.share(event.title, "http://52.77.122.228/uploads/events/${event.imageUrl}", "https://thedipaar.com/detailevents/${event.id}");
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE93314),
                  borderRadius:
                      BorderRadius.circular(15), // Adjust the radius as needed
                ),
                child: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarker(
      BuildContext context, DateTime date, List<Event>? events) {
    if (events != null && events.isNotEmpty) {
      // Count the number of events for the current date
      int eventCount =
          events.where((event) => _isSameDay(event.start, date)).length;

      if (eventCount > 0) {
        // Display markers corresponding to the number of events
        List<Color> markerColors = [
          const Color(0xff23527C),
          const Color(0xffE93314),
          const Color(0xff67C24A),
          const Color(0xffFFC107),
          const Color(0xff9C27B0),
        ];

        return Positioned(
          bottom: 1,
          child: Row(
            children: List.generate(
              eventCount > 5
                  ? 5
                  : eventCount, // Limit to maximum 5 markers per date
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: markerColors[index],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      }
    }
    return Container(); // Return an empty container if there are no events or the date has no events
  }

  bool _isSameDay(DateTime dateA, DateTime dateB) {
    return dateA.year == dateB.year &&
        dateA.month == dateB.month &&
        dateA.day == dateB.day;
  }
}
