import 'package:aussie/presentation/screens/feed/events/widgets/event_creation_form_fields.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/banner_picker.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/gallery_picker_button.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/gallery_status.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/location_picker.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/submit.dart';
import 'package:aussie/state/eventmanagement/cubit/eventmanagement_cubit.dart';
import 'package:aussie/util/functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCreationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffkey = GlobalKey();

    return Scaffold(
      key: scaffkey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: .5.sh,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(getTranslation(context, "eventCreationTitle")),
              background: EventBannerPicker(),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EventCreationFormFields(),
                EventLocationPicker(),
                EventImageGalleryStatus(),
                EventImageGalleryPickerButton(),
                BlocBuilder<EventManagementCubit, EventManagementState>(
                  builder: (context, state) {
                    if (state is EventManagementPerformingAction) {
                      return Center(child: getIndicator(context));
                    }
                    return Container();
                  },
                ),
                BlocConsumer<EventManagementCubit, EventManagementState>(
                  listener: (context, state) {
                    if (state is EventManagementCreated) {
                      _sn("Event created", scaffkey);
                      Future.delayed(Duration(seconds: 2))
                          .whenComplete(() => Navigator.of(context).pop());
                    } else if (state is EventManagementError) {
                      _sn("Failed to create Event", scaffkey);
                    }
                  },
                  builder: (context, state) {
                    if (state is EventManagementPerformingAction)
                      return EventCreationSubmitButton(
                        enabled: false,
                      );
                    else if (state is EventManagementCreated) {
                      return EventCreationSubmitButton(
                        enabled: false,
                      );
                    } else {
                      return EventCreationSubmitButton(
                        enabled: true,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sn(String text, GlobalKey<ScaffoldState> scaffkey) {
    scaffkey.currentState.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
