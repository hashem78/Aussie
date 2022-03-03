import 'package:evento/presentation/screens/feed/events/widgets/form/event_creation_form.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCreationScreen extends StatelessWidget {
  const EventCreationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              title: Text(
                'New Event',
                style: TextStyle(
                  fontSize: 100.sp,
                  //color: correctColor,
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(
                child: EventCreationForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
