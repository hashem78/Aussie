import 'package:aussie/models/usermanagement/events/creation/eventcreation_model.dart';
import 'package:aussie/presentation/screens/feed/tabs/events/tab.dart';
import 'package:aussie/presentation/screens/feed/tabs/home/tab.dart';
import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/presentation/widgets/aussie/scaffold.dart';
import 'package:aussie/state/eventmanagement/cubit/eventmanagement_cubit.dart';
import 'package:aussie/state/image_picking/cubit/image_picking_cubit.dart';
import 'package:aussie/state/location_picking/cubit/locationpicking_cubit.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;
  final UserManagementCubit cubit = UserManagementCubit();

  @override
  void initState() {
    super.initState();
    cubit.getUserData();
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      body: BlocProvider.value(
        value: cubit,
        child: BlocBuilder<UserManagementCubit, UserManagementState>(
          builder: (context, state) {
            if (state is UserMangementHasUserData) {
              return Provider.value(
                value: state.user,
                child: SafeArea(
                  child: AussieScaffold(
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventCreationScreen(),
                          ),
                        );
                      },
                      child: Icon(Icons.add, size: 100.sp),
                    ),
                    drawer: AussieAppDrawer(),
                    body: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        SliverSafeArea(
                          sliver: SliverAppBar(
                            primary: true,
                            pinned: true,
                            centerTitle: true,
                            title: Text(
                              "Feed",
                              style: TextStyle(
                                  fontSize: 60.sp, fontWeight: FontWeight.w400),
                            ),
                            elevation: 0,
                            bottom: TabBar(
                              controller: controller,
                              tabs: [
                                Icon(Icons.home),
                                Icon(Icons.event),
                              ],
                            ),
                          ),
                        ),
                      ],
                      body: TabBarView(
                        controller: controller,
                        children: [
                          HomeTab(),
                          EventsTab(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            print("====================");
            print("stuck in feed.dart because the user still doesnt have data");
            print("====================");
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class EventCreationBlocForm extends FormBloc<String, String> {
  // ignore: close_sinks
  final dateAndTime1 = InputFieldBloc<DateTime, Object>(
    validators: [FieldBlocValidators.required],
  );
  // ignore: close_sinks
  final dateAndTime2 = InputFieldBloc<DateTime, Object>(
    validators: [FieldBlocValidators.required],
  );
  // ignore: close_sinks
  final timeonly1 = InputFieldBloc<TimeOfDay, Object>(
    validators: [FieldBlocValidators.required],
  );

  // ignore: close_sinks
  final timeonly2 = InputFieldBloc<TimeOfDay, Object>(
    validators: [FieldBlocValidators.required],
  );

  // ignore: close_sinks
  final description = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  // ignore: close_sinks
  final title = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  // ignore: close_sinks
  final subtitle = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  EventCreationBlocForm() {
    addFieldBlocs(fieldBlocs: [
      dateAndTime1,
      dateAndTime2,
      timeonly1,
      timeonly2,
      title,
      subtitle,
      description,
    ]);
  }
  String profileImagePath;

  @override
  void onSubmitting() {}
}

class EventCreationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => EventCreationBlocForm()),
          BlocProvider(create: (context) => EventmanagementCubit()),
          BlocProvider(create: (context) => ImagePickingCubit()),
          BlocProvider(create: (context) => LocationPickingCubit()),
        ],
        child: Builder(
          builder: (context) {
            // ignore: close_sinks
            final _formBloc = BlocProvider.of<EventCreationBlocForm>(context);
            final _multiImageCubit =
                BlocProvider.of<ImagePickingCubit>(context);
            final _singleImageCubit = ImagePickingCubit();
            final _evmCubit = BlocProvider.of<EventmanagementCubit>(context);
            final _locCubit = BlocProvider.of<LocationPickingCubit>(context);

            return FormBlocListener<EventCreationBlocForm, String, String>(
                child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: .5.sh,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text("New event"),
                    background: Stack(
                      alignment: Alignment.center,
                      children: [
                        BlocProvider.value(
                          value: _singleImageCubit,
                          child:
                              BlocBuilder<ImagePickingCubit, ImagePickingState>(
                            builder: (context, state) {
                              if (state is ImagePickingSingleDone)
                                return Ink.image(
                                  image: MemoryImage(
                                    state.data.buffer.asUint8List(),
                                  ),
                                  fit: BoxFit.cover,
                                );
                              else
                                return Container();
                            },
                          ),
                        ),
                        IconButton(
                          tooltip: "Add a banner",
                          icon: Icon(Icons.add),
                          onPressed: () {
                            _singleImageCubit.pickImage();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      TextFieldBlocBuilder(
                        textFieldBloc: _formBloc.title,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_pin),
                          border: InputBorder.none,
                          filled: true,
                          labelText: "Title",
                          hintText: "Make it descriptive",
                        ),
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: _formBloc.subtitle,
                        maxLines: null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_pin),
                          border: InputBorder.none,
                          filled: true,
                          labelText: "Subtitle",
                          hintText: "Could be a location for example",
                        ),
                      ),
                      DateTimeFieldBlocBuilder(
                        dateTimeFieldBloc: _formBloc.dateAndTime1,
                        format: DateFormat.yMMMMEEEEd(),
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          filled: true,
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.date_range),
                          hintText: "The date of the the Event",
                        ),
                      ),
                      DateTimeFieldBlocBuilder(
                        dateTimeFieldBloc: _formBloc.dateAndTime2,
                        format: DateFormat.yMMMMEEEEd(),
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        decoration: InputDecoration(
                          labelText: 'End Date',
                          filled: true,
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.date_range),
                          hintText: "The date the event ends",
                        ),
                      ),
                      TimeFieldBlocBuilder(
                        timeFieldBloc: _formBloc.timeonly1,
                        format: DateFormat('hh:mm a'),
                        initialTime: TimeOfDay.now(),
                        decoration: InputDecoration(
                          labelText: 'Starting Time',
                          filled: true,
                          border: InputBorder.none,
                          hintText: "Time of day",
                          prefixIcon: Icon(Icons.access_time),
                        ),
                      ),
                      TimeFieldBlocBuilder(
                        timeFieldBloc: _formBloc.timeonly2,
                        format: DateFormat('hh:mm a'),
                        initialTime: TimeOfDay.now(),
                        decoration: InputDecoration(
                          labelText: 'Ending Time',
                          filled: true,
                          border: InputBorder.none,
                          hintText: "Time of day",
                          prefixIcon: Icon(Icons.access_time),
                        ),
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: _formBloc.description,
                        maxLines: null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_pin),
                          border: InputBorder.none,
                          filled: true,
                          hintText: "Description",
                        ),
                      ),
                      BlocBuilder<LocationPickingCubit, LocationPickingState>(
                        cubit: _locCubit,
                        builder: (context, state) {
                          return TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.map),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  var _k = await Navigator.of(context).push(
                                    MaterialPageRoute<LocationResult>(
                                      builder: (context) => PlacePicker(
                                        "AIzaSyBs7N7qU5nNLY-fNcnesbnJFJZ3bo55o6k",
                                        displayLocation:
                                            LatLng(-33.8688, 151.2093),
                                      ),
                                    ),
                                  );
                                  _locCubit.pickLoc(_k);
                                },
                                icon: Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                ),
                              ),
                              border: InputBorder.none,
                              filled: true,
                              hintText: state.message,
                            ),
                          );
                        },
                      ),
                      BlocBuilder(
                        cubit: _multiImageCubit,
                        builder: (context, state) {
                          if (state is ImagePickingLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is ImagePickingMultiError) {
                            return Container(
                              height: 100,
                              width: 100,
                              color: Colors.red,
                            );
                          } else if (state is ImagePickingMultiDone) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                Text("Added images"),
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                      BlocListener(
                        cubit: _evmCubit,
                        listener: (context, state) {
                          if (state is EventmanagementCreated) {
                            Scaffold.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Event created"),
                              ),
                            );
                            Future.delayed(Duration(seconds: 2)).whenComplete(
                              () => Navigator.of(context).pop(),
                            );
                          } else if (state is EventmanagementError) {
                            print(state.runtimeType);
                            Scaffold.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("An error occured"),
                              ),
                            );
                          }
                        },
                        child: Container(),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          context.read<ImagePickingCubit>().pickImages();
                        },
                        child: Text("Pick Images"),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          final _start = _formBloc.dateAndTime1.value;
                          final _startTime = _formBloc.timeonly1.value;
                          final _end = _formBloc.dateAndTime2.value;
                          final _endTime = _formBloc.timeonly2.value;
                          final _combined1 = DateTime(
                            _start.year,
                            _start.month,
                            _start.day,
                            _startTime.hour,
                            _startTime.minute,
                          );
                          final _combined2 = DateTime(
                            _end.year,
                            _end.month,
                            _end.day,
                            _endTime.hour,
                            _endTime.minute,
                          );

                          _evmCubit.addEvent(
                            EventCreationModel(
                              startingTimeStamp:
                                  _combined1.millisecondsSinceEpoch,
                              endingTimeStamp:
                                  _combined2.millisecondsSinceEpoch,
                              lat: _locCubit.value.latLng.latitude,
                              lng: _locCubit.value.latLng.longitude,
                              title: _formBloc.title.value,
                              subtitle: _formBloc.subtitle.value,
                              description: _formBloc.description.value,
                              imageData: _multiImageCubit.values,
                              bannerData: _singleImageCubit.value,
                            ),
                          );
                        },
                        child: Text("Create Event"),
                      )
                    ],
                  ),
                ),
              ],
            ));
          },
        ),
      ),
    );
  }
}
