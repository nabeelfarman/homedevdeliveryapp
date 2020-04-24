import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:homemobileapp/pages/customerPages/customerHome.dart';
import 'package:homemobileapp/main.dart';
import 'package:homemobileapp/pages/newOrder.dart';

abstract class NavigationEvents extends Equatable {
  // CustomerHomeClickedEvent,
  // NewOrderClickedEvent,
  // ProfileClickedEvent,
  NavigationEvents([List props = const []]) : super(props);
}

class customerHome extends NavigationEvents {
  final int userID;
  final int townID;

  customerHome({
    @required this.userID,
    @required this.townID,
  }) : super([userID]);

  @override
  String toString() => 'customerHome';
}

class newOrder extends NavigationEvents {
  final int userID;
  final int townID;

  newOrder({
    @required this.userID,
    @required this.townID,
  }) : super([userID]);

  @override
  String toString() => 'newOrder { userID: $userID }';
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  int userID;
  int townID;

  @override
  NavigationBloc(
    this.userID,
    this.townID,
  );

  @override
  NavigationStates get initialState => CustomerHome(
        userID: userID,
        townID: townID,
      );

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    if (event is customerHome) {
      yield CustomerHome(
        userID: event.userID,
        townID: event.townID,
      );
    }
    if (event is newOrder) {
      yield NewOrderPage(
        userID: event.userID,
        townID: event.townID,
      );
    }
    // switch (event) {
    //   case NavigationEvents.CustomerHomeClickedEvent:
    //     yield CustomerHome();
    //     break;
    //   case NavigationEvents.NewOrderClickedEvent:
    //     yield NewOrderPage();
    //     break;
    // }
  }
}
