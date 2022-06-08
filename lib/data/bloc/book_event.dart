part of 'book_bloc.dart';

@immutable
abstract class BookEvent extends Equatable {
  const BookEvent();
}

class LoadBookEvent extends BookEvent {
  @override
  List<Object> get props => [];
}

class ChangeStatusBookEvent extends BookEvent {
  final bool status;
  final int index;

  const ChangeStatusBookEvent(this.status, this.index);

  @override
  List<Object> get props => [];
}

class ChangeRateBookEvent extends BookEvent {
  final String rate;
  final int index;

  const ChangeRateBookEvent(this.rate, this.index);

  @override
  List<Object> get props => [];
}
