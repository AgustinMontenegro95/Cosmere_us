part of 'book_bloc.dart';

@immutable
abstract class BookState extends Equatable {}

class BookLoadingState extends BookState {
  @override
  List<Object?> get props => [];
}

class BookLoadedState extends BookState {
  final List<Book> books;

  BookLoadedState(this.books);

  @override
  List<Object?> get props => [];
}

class BookErrorState extends BookState {
  final String error;

  BookErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
