import 'package:riverpod/legacy.dart';
import '../models/department_model.dart';

class GameState {
  final int lives;
  final int score;
  final List<Department> remainingDepartments;
  final Department? currentDepartment;

  GameState({
    this.lives = 3,
    this.score = 0,
    this.remainingDepartments = const [],
    this.currentDepartment,
  });

  GameState copyWith({
    int? lives,
    int? score,
    List<Department>? remainingDepartments,
    Department? currentDepartment,
  }) {
    return GameState(
      lives: lives ?? this.lives,
      score: score ?? this.score,
      remainingDepartments: remainingDepartments ?? this.remainingDepartments,
      currentDepartment: currentDepartment ?? this.currentDepartment,
    );
  }
}

// El Notificador que controlará la lógica
class GameNotifier extends StateNotifier<GameState> {
  GameNotifier() : super(GameState());

  void startGame(List<Department> departments) {
    state = state.copyWith(
      remainingDepartments: departments,
      currentDepartment: departments.first,
    );
  }

  void loseLife() {
    if (state.lives > 0) {
      state = state.copyWith(lives: state.lives - 1);
    }
  }
}

final gameProvider = StateNotifierProvider<GameNotifier, GameState>(
  (ref) => GameNotifier(),
);
