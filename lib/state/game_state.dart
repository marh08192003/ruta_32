import 'package:flutter_riverpod/legacy.dart';
import '../models/department_model.dart';
import '../data/departments_data.dart';

class GameState {
  final int lives;
  final int score;
  final int currentIndex; // Índice de la pieza actual en la lista (0-31)
  final List<int> placedIds; // IDs de los ya ubicados con éxito
  final bool isGameOver;
  final bool isPaused;

  GameState({
    this.lives = 3,
    this.score = 0,
    this.currentIndex = 0,
    this.placedIds = const [],
    this.isGameOver = false,
    this.isPaused = false,
  });

  Department get currentDept => allDepartments[currentIndex];

  GameState copyWith({
    int? lives,
    int? score,
    int? currentIndex,
    List<int>? placedIds,
    bool? isGameOver,
    bool? isPaused,
  }) {
    return GameState(
      lives: lives ?? this.lives,
      score: score ?? this.score,
      currentIndex: currentIndex ?? this.currentIndex,
      placedIds: placedIds ?? this.placedIds,
      isGameOver: isGameOver ?? this.isGameOver,
      isPaused: isPaused ?? this.isPaused,
    );
  }
}

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier() : super(GameState());

  void onRightPlacement() {
    final nextIndex = state.currentIndex + 1;

    final updatedPlacedIds = [...state.placedIds, state.currentDept.idCaida];

    if (nextIndex < allDepartments.length) {
      state = state.copyWith(
        score: state.score + 10,
        placedIds: updatedPlacedIds,
        currentIndex: nextIndex,
      );
    } else {
      // ¡VICTORIA! Todos los departamentos (32) ubicados
      state = state.copyWith(
        score: state.score + 100, // Bono por ganar
        placedIds: updatedPlacedIds,
        isGameOver: true,
      );
    }
  }

  void onWrongPlacement() {
    if (state.lives > 1) {
      state = state.copyWith(lives: state.lives - 1);
    } else {
      state = state.copyWith(lives: 0, isGameOver: true);
    }
  }

  void resetGame() {
    state = GameState();
  }

  void setPaused(bool paused) {
    state = state.copyWith(isPaused: paused);
  }

  void addExtraLife() {
    state = state.copyWith(lives: 3, isGameOver: false, isPaused: true);
  }
}

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier();
});
