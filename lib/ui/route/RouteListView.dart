import 'package:alto_minho_mobilidade/utils/Networking/GetRoutes.dart';
import 'package:alto_minho_mobilidade/models/LegModel.dart';
import 'package:alto_minho_mobilidade/utils/constants.dart';
import 'package:alto_minho_mobilidade/utils/size_config.dart';
import 'package:alto_minho_mobilidade/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:alto_minho_mobilidade/utils/Networking/ApiModels/From.dart';

class RouteListView extends StatefulWidget {
  final GetRoutes getRoutes;
  final Place fromPlace;
  final Place toPlace;

  const RouteListView(this.getRoutes, this.fromPlace, this.toPlace);

  @override
  _RouteListViewState createState() => _RouteListViewState();
}

class _RouteListViewState extends State<RouteListView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_increaseDummyLegs();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        child: Column(
      children: [
        _routeHeader(),
        Expanded(
          child: _routeLegs(),
        )
      ],
    ));
  }

  _increaseDummyLegs() {
    final leg = widget.getRoutes.plan.itineraries[0].legs[0];
    widget.getRoutes.plan.itineraries[0].legs.add(leg);
    widget.getRoutes.plan.itineraries[0].legs.add(leg);
    widget.getRoutes.plan.itineraries[0].legs.add(leg);
    widget.getRoutes.plan.itineraries[0].legs.add(leg);
  }

  _routeHeader() {
    double tempDistance = 0;
    final firstItinerary = widget.getRoutes.plan.itineraries[0];
    firstItinerary.legs.forEach((element) {
      tempDistance += element.distance;
    });

    final distance = DistanceUtil.toReadableDistance(tempDistance);
    final startTime = TimeUtil.toReadableTime(firstItinerary.startTime);
    final endTime = TimeUtil.toReadableTime(firstItinerary.endTime);
    return Container(
      padding: EdgeInsets.all(20.0),
      color: ColorConstant.routeListTopSectionColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                startTime,
                style: TextStyleConstant.titleStyleBlack16,
              ),
              Text(
                ' - ',
                style: TextStyleConstant.titleStyleBlack16,
              ),
              Text(
                endTime,
                style: TextStyleConstant.titleStyleBlack16,
              )
            ],
          ),
          Text(
            distance,
            style: TextStyleConstant.titleStyleBlack16,
          )
        ],
      ),
    );
  }

  List<LegModel> _getLegModels() {
    final List<LegModel> legs = [];
    final firstItinerary = widget.getRoutes.plan.itineraries[0];
    final length = firstItinerary.legs.length;
    for (int i = 0; i < length; i++) {
      LegModel temp;
      IconData modeIconData;
      Color modeIconColor;
      String mode;
      final leg = firstItinerary.legs[i];

      if (leg.mode == ModeConstants.WALK) {
        modeIconData = Icons.directions_walk;
        modeIconColor = ColorConstant.walkIconBackgroundColor;
        mode = TranslationConstant.WALK;
      } else if (leg.mode.contains(ModeConstants.BUS)) {
        modeIconColor = ColorConstant.busIconBackgroundColor;
        modeIconData = Icons.directions_bus;
        mode = TranslationConstant.BUS + ' (${leg.mode})';
      } else if (leg.mode == ModeConstants.BICYCLE) {
        modeIconColor = ColorConstant.bicycleIconBackgroundColor;
        modeIconData = Icons.directions_bike;
        mode = TranslationConstant.BICYCLE;
      } else if (leg.mode == ModeConstants.CAR) {
        modeIconData = Icons.directions_car;
        modeIconColor = ColorConstant.carIconBackgroundColor;
        mode = TranslationConstant.CAR;
      } else if (leg.mode == ModeConstants.TRANSIT_WALK) {
        modeIconColor = ColorConstant.transitWalkBackgroundColor;
        modeIconData = Icons.directions_transit;
        mode = TranslationConstant.TRANSIT_WALK;
      } else {
        throw Exception('Mode not Set');
      }

      if (i == 0 || i == length - 1) {
        if (i == 0) {
          temp = LegModel(Icons.my_location, ColorConstant.secondaryColor,
              TimeUtil.toReadableTime(leg.startTime), widget.fromPlace.description,
              isFirst: true,
              bottomLineColor: modeIconColor,
              distance: DistanceUtil.toReadableDistance(leg.distance),
              modeIcon: modeIconData,
              modeIconBackgroundColor: modeIconColor,
              mode: mode);
          legs.add(temp);
        }
        if (i == length - 1) {
          temp = LegModel(
            Icons.pin_drop,
            ColorConstant.secondaryColor,
            TimeUtil.toReadableTime(leg.endTime),
            widget.toPlace.description,
            isLast: true,
            topLineColor:
                i == 0 ? legs[0].bottomLineColor : legs[i - 1].bottomLineColor,
          );
          legs.add(temp);
        }
      } else {
        temp = LegModel(CupertinoIcons.circle_filled, Colors.grey,
            TimeUtil.toReadableTime(leg.startTime), leg.from.name,
            isMiddle: true,
            topLineColor: legs[i - 1].bottomLineColor,
            bottomLineColor: modeIconColor,
            modeIcon: modeIconData,
            modeIconBackgroundColor: modeIconColor,
            mode: mode,
            distance: DistanceUtil.toReadableDistance(leg.distance));
        legs.add(temp);
      }
    }
    return legs;
  }

  _routeLegs() {
    final legModels = _getLegModels();
    final lineWidth = 4.0;
    final midContainerWidth = 40.0;
    final leftSectionWidth = 100.0;
    final bottomContainerHeight = 100.0;
    final iconSize = 24.0;
    final topSectionHeight = 60.0;
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final leg = legModels[index];
          return Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: leftSectionWidth,
                        height: topSectionHeight,
                        alignment: Alignment.centerRight,
                        child: Text(
                          leg.time,
                          style: TextStyleConstant.titleStyleBlack16,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: midContainerWidth,
                        height: topSectionHeight,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            !leg.isFirst
                                ? Container(
                                    width: lineWidth,
                                    color: leg.topLineColor,
                                    height:
                                        (topSectionHeight / 2) - iconSize / 2,
                                  )
                                : SizedBox(
                                    height:
                                        (topSectionHeight / 2) - iconSize / 2,
                                  ),
                            Icon(
                              leg.iconData,
                              color: leg.iconColor,
                              size: iconSize,
                            ),
                            !leg.isLast
                                ? Container(
                                    width: lineWidth,
                                    color: leg.bottomLineColor,
                                    height:
                                        (topSectionHeight / 2) - iconSize / 2,
                                  )
                                : SizedBox(
                                    height:
                                        (topSectionHeight / 2) - iconSize / 2,
                                  )
                          ],
                        ),
                      ),
                      Container(
                          width: SizeConfig.screenWidth -
                              leftSectionWidth -
                              midContainerWidth,
                          height: topSectionHeight,
                          alignment: Alignment.centerLeft,
                          child: leg.isMiddle
                              ? Text(
                                  leg.address,
                                  style: TextStyleConstant.titleStyleBlack16,
                                )
                              : RichText(
                                  text: TextSpan(
                                    style: TextStyleConstant.titleStyleBlack16,
                                    children: [
                                      TextSpan(
                                        text: leg.isFirst? TranslationConstant.ORIGIN : TranslationConstant.DESTINATION,
                                      ),
                                      TextSpan(
                                        text:  '\n' + leg.address,
                                        style: TextStyleConstant.titleStyleBlackBold16
                                      )
                                    ]
                                  ),
                                ))
                    ],
                  ),
                  !leg.isLast
                      ? Row(
                          children: [
                            Container(
                              width: leftSectionWidth,
                              height: bottomContainerHeight,
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: leg.modeIconBackgroundColor,
                                ),
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  leg.modeIcon,
                                  color: ColorConstant
                                      .routeListItemSeparatorIconColor,
                                ),
                              ),
                            ),
                            Container(
                              width: midContainerWidth,
                              height: bottomContainerHeight,
                              alignment: Alignment.center,
                              child: Container(
                                width: lineWidth,
                                color: leg.bottomLineColor,
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth -
                                  leftSectionWidth -
                                  midContainerWidth,
                              height: bottomContainerHeight,
                              padding: EdgeInsets.only(right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Opacity(
                                      opacity: .5,
                                      child: Text(
                                        leg.mode,
                                        style:
                                            TextStyleConstant.titleStyleBlack16,
                                      )),
                                  Opacity(
                                      opacity: 0.5,
                                      child: Text(
                                        leg.distance,
                                        style:
                                            TextStyleConstant.titleStyleBlack16,
                                      )),
                                ],
                              ),
                            )
                          ],
                        )
                      : SizedBox.shrink()
                ],
              )
            ],
          );
        },
        itemCount: legModels.length);
  }
}