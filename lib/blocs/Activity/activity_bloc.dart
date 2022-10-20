import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nicotine/models/MyActivity.dart';
import 'package:nicotine/resources/firebase_services/MyActivityFirestoreService.dart';

import '../../models/User.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(ActivityInitial());
  final myActivityService = MyActivityFirestoreService();

  @override
  Stream<ActivityState> mapEventToState(
    ActivityEvent event,
  ) async* {
    if (event is GetUserActivities) {
      try {
        print("ActivityBloc: GetUserActivities event");

        final allActivities = await myActivityService.getUserActivities();
        yield UserActivitiesRetrieved(activities: allActivities);
      } catch (e) {
        print('Error in GetUserActivities event: $e');
        yield ActivityError(error: e.toString());
      }
    } else if (event is AddActivity) {
      try {
        final added = await myActivityService.addActivity(
            event.user,
            event.activityName,
            event.foodAte,
            event.glassesOfWater,
            event.cigarettesSmoked,
            event.herbalMix,
            event.stepsWalked,
            event.activityPoints);

        yield ActivityAdded();
      } catch (e) {
        print('Error in InsertAffirmation event: $e');
        yield ActivityError(error: e.toString());
      }
    } else if (event is ResetActivityState) {
      yield ActivityInitial();
    }
  }
}
