import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nicotine/resources/firebase_services/GoalFirestoreService.dart';

import '../../models/User.dart';
import '../../models/UserGoal.dart';

part 'goal_event.dart';
part 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  GoalBloc() : super(GoalInitial());
  final userGoalService = GoalFirestoreService();

  @override
  Stream<GoalState> mapEventToState(
    GoalEvent event,
  ) async* {
    if (event is GetUserGoals) {
      try {
        print("GoalBloc: GetUserGoals event");

        final allUserGoals = await userGoalService.getAllUserGoals();
        yield UserGoalsRetrieved(goals: allUserGoals);
      } catch (e) {
        print('Error in GetUserActivities event: $e');
        yield GoalError(error: e.toString());
      }
    } else if (event is AddGoal) {
      try {
        print("GoalBloc: AddGoal event");

        final added = await userGoalService.createGoal(

          event.user!,
          event.goalName,
          // event.goalDescription,
          // event.goalStatus,
          event.goalDays,
          event.goalDate,
          // event.goalTimeSlot
        );

        yield GoalAdded();
      } catch (e) {
        print('Error in create goal event: $e');
        yield GoalError(error: e.toString());
      }
    } else if (event is AddGoalToCancelList) {
      try {
        print("GoalBloc: AddGoalToCancelList event");

        final added = await userGoalService.addToCancelGoal(
          event.user,
          event.goalToCancel,
        );
        if (added) {
          yield GoalAdded();
        }
      } catch (e) {
        print('Error in AddGoalToCancelList event: $e');
        yield GoalError(error: e.toString());
      }
    } else if (event is DeleteAGoal) {
      try {
        print("GoalBloc: DeleteAGoal event");

        final added = await userGoalService.deleteGoal(
          event.goalId,
        );
        if (added) {
          yield GoalAdded();
        }
      } catch (e) {
        print('Error in DeleteAGoal event: $e');
        yield GoalError(error: e.toString());
      }
    } else if (event is ResetGoalState) {
      yield GoalInitial();
    }
  }
}
