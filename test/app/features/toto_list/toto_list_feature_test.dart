import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/entities/task_entity.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/domain/repositories/task_repository.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_cubit.dart';
import 'package:saturne_todo_app_djamo/app/features/toto_list/presentation/bloc/task_list_state.dart';

@GenerateMocks([TaskRepository]) // Génère un mock pour TaskRepository
import 'toto_list_feature_test.mocks.dart';

void main() {
  late MockTaskRepository mockTaskRepository;
  late TaskListCubit taskListCubit;

  setUp(() {
    // Initialiser les mocks et le Cubit avant chaque test
    mockTaskRepository = MockTaskRepository();
    taskListCubit = TaskListCubit(mockTaskRepository);
  });

  group('TaskListCubit with mocked repository', () {
    test('Initial state is TaskListState.initial()', () {
      // Vérifie que l'état initial du Cubit est `initial`
      expect(taskListCubit.state, equals(const TaskListState.initial()));
    });

    test('fetchTasks emits loading and data states with mocked tasks',
        () async {
      // Arrange
      final mockTasks = [
        TaskEntity(
            id: 1,
            title: 'Task 1',
            isCompleted: false,
            createdAt: DateTime.now()),
        TaskEntity(
            id: 2,
            title: 'Task 2',
            isCompleted: true,
            createdAt: DateTime.now()),
      ];

      when(mockTaskRepository.getAllTasks()).thenAnswer((_) async => mockTasks);

      // Act & Assert
      expectLater(
        taskListCubit.stream,
        emitsInOrder([
          const TaskListState.loading(),
          TaskListState.data(mockTasks),
        ]),
      );

      await taskListCubit.fetchTasks();
    });

    test('addTask simulates adding a task without interacting with Isar',
        () async {
      // Arrange
      final newTask = TaskEntity(
          id: 3,
          title: 'New Task',
          isCompleted: false,
          createdAt: DateTime.now());

      when(mockTaskRepository.addTask(newTask)).thenAnswer((_) async {});
      when(mockTaskRepository.getAllTasks()).thenAnswer((_) async => [newTask]);

      // Act
      await taskListCubit.addTask(newTask);

      // Assert
      verify(mockTaskRepository.addTask(newTask)).called(1);
      verify(mockTaskRepository.getAllTasks()).called(1);
    });

    test('deleteTask simulates deleting a task without interacting with Isar',
        () async {
      // Arrange
      const taskId = 1;

      when(mockTaskRepository.deleteTask(taskId)).thenAnswer((_) async {});
      when(mockTaskRepository.getAllTasks()).thenAnswer((_) async => []);

      // Act
      await taskListCubit.deleteTask(taskId);

      // Assert
      verify(mockTaskRepository.deleteTask(taskId)).called(1);
      verify(mockTaskRepository.getAllTasks()).called(1);
    });

    test('fetchTasks emits error state on failure', () async {
      // Arrange
      const errorMessage = 'An error occurred';
      when(mockTaskRepository.getAllTasks()).thenThrow(Exception(errorMessage));

      // Act & Assert
      expectLater(
        taskListCubit.stream,
        emitsInOrder([
          const TaskListState.loading(),
          const TaskListState.error(errorMessage),
        ]),
      );

      await taskListCubit.fetchTasks();
    });
  });
}
