import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/models/gmap.dart';
import 'package:aussie/presentation/screens/info/teritories/teritories.dart';
import 'package:aussie/util/functions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class EventCardStack extends StatelessWidget {
  const EventCardStack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventModel e = getEventModel(context);
    final DateTime begin =
        DateTime.fromMillisecondsSinceEpoch(e.startingTimeStamp!);
    final DateTime end =
        DateTime.fromMillisecondsSinceEpoch(e.endingTimeStamp!);
    final formattedBeginDate = DateFormat("dd/MM/yyyy").format(begin);
    final formattedEndDate = DateFormat("dd/MM/yyyy").format(end);
    final formattedBeginTime = DateFormat("hh:mm:ss").format(begin);
    final formattedEndTime = DateFormat("hh:mm:ss").format(end);
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            child: AutoSizeText(
              e.title!,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.black),
            ),
          ),
          AutoSizeText(
            e.subtitle!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedBeginDate,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.green),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Starts $formattedBeginTime",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formattedEndDate,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.red),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      "Ends $formattedEndTime",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AussieGMapScreen(
                          model: AussieGMapModel(
                            longitude: e.lng.toString(),
                            latitude: e.lat.toString(),
                            title: "",
                          ),
                        );
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                      ),
                      Expanded(
                        child: AutoSizeText(
                          e.address!,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
