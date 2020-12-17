import 'package:aussie/presentation/screens/feed/tabs/events/widgets/event_creation_form_fields.dart';
import 'package:aussie/presentation/screens/feed/tabs/events/widgets/form/banner_picker.dart';
import 'package:aussie/presentation/screens/feed/tabs/events/widgets/form/gallery_picker_button.dart';
import 'package:aussie/presentation/screens/feed/tabs/events/widgets/form/gallery_status.dart';
import 'package:aussie/presentation/screens/feed/tabs/events/widgets/form/location_picker.dart';
import 'package:aussie/presentation/screens/feed/tabs/events/widgets/form/submit.dart';
import 'package:aussie/state/eventmanagement/cubit/eventmanagement_cubit.dart';

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
              title: Text("New event"),
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
                    print("here");
                    if (state is EventManagementPerformingAction) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Container();
                  },
                ),
                EventCreationSubmitButton(scaffkey: scaffkey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
