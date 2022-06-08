import 'package:bloc/bloc.dart';
import 'package:cosmere_us/data/repository/book_repository.dart';
import 'package:cosmere_us/models/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository _bookRepository;

  BookBloc(this._bookRepository) : super(BookLoadingState()) {
    on<LoadBookEvent>((event, emit) async {
      emit(BookLoadingState());
      try {
        final book = await _bookRepository.getBooks();
        emit(BookLoadedState(book));
      } catch (e) {
        emit(BookErrorState(e.toString()));
      }
    });

    on<ChangeStatusBookEvent>((event, emit) async {
      emit(BookLoadingState());
      try {
        await _bookRepository.statusBook(event.status, event.index);
        final book = await _bookRepository.getBooks();
        emit(BookLoadedState(book));
      } catch (e) {
        emit(BookErrorState(e.toString()));
      }
    });

    on<ChangeRateBookEvent>((event, emit) async {
      emit(BookLoadingState());
      try {
        await _bookRepository.rateBook(event.rate, event.index);
        final book = await _bookRepository.getBooks();
        emit(BookLoadedState(book));
      } catch (e) {
        emit(BookErrorState(e.toString()));
      }
    });
  }
}
