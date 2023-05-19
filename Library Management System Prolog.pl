:-dynamic(issued/3).
:-dynamic(book/4).
book(book1,'The Catcher in the Rye', 'J.D. Salinger',3).
book(book2,'To Kill a Mockingbird', 'Harper Lee',4).
book(book3,'The Great Gatsby', 'F. Scott Fitzgerald',3).
book(book4,'Letting Go','Philip Roth',2).
book(book5,'Fear of Flying','Erica Jong',3).
book(book6,'When Breath Beacomes Air','Paul Kalanithi',2).
book(book7,'The Adventures of Tom Sawyer','Mark Twain',1).
book(book8,'In the Heart of the Sea','Nathaniel Philbrick',5).
book(book9,'Little Women','Louisa May Alcott',2).
book(book10,'The Perfect Neighbors','Sarah Pekkanen',1).
issued(book1,date(2022,10,5),2).
issued(book2,date(0,0,0),0).
issued(book3,date(2022,9,19),3).
issued(book4,date(0,0,0),0).
issued(book5,date(2022,6,24),2).
issued(book6,date(2022,4,10),1).
issued(book7,date(0,0,0),0).
issued(book8,date(2022,8,14),3).
issued(book9,date(0,0,0),0).
issued(book10,date(0,0,0),0).
library:-
 writeln('----------Welcome to Public Library----------'),
 writeln('What would you like to do.'),
 writeln('1.Check availability of a book.'),
 writeln('2.Get details of a book.'),
 writeln('3.Issue a book.'),
 writeln('4.Return a book.'),
 writeln('5. Delete a book.'),
 writeln('6. Exit program.'),
 read(X),
(X=1->
  write('Enter book ID:'),nl,
  read(Y),
  avail_book(Y);
 X=:=2->
  write('Enter the book ID:'),nl,
 read(B),
  search_book(B),
  avail_book(B);
 X=:=3->
  write('Enter book ID to be issued'),nl,
  read(W),
  write("Enter today's date"),
  read(V),
  issue_book(W,V);
 X=:=4->
  write('Enter book ID to be returned:'),nl,
  read(Z),
  return_book(Z);
 X=:=5->
  write('Enter the book ID to be deleted:'),nl,
  read(A),
  delete_book(A);
 X=:=6->abort).

avail_book(ID):-issued(ID,_,Count),book(ID,_,_,Copies),
                Count<Copies,
                writeln('The book is available to issue.');
                write('The book is not available to issue').

return_book(ID):-issued(ID,_,Count),
                 retract(issued(ID,_,Count)),
                 asserta(issued(ID,_,Count-1)).

issue_book(ID,Date):-issued(ID,_,Count),book(ID,_,_,Copies),
                     Count<Copies,
                     retract(issued(ID,_,Count)),
                     asserta(issued(ID,Date,Count+1)),
                     write('The book is issued');
                     write('The book is currently not availble') .

delete_book(ID):- retract(book(ID,C,D,Copies)),
                  asserta(book(ID,C,D,Copies-1)).

search_book(ID):- book(ID,C,D,Copies),
                  issued(ID,_,Count),
                  format('The name of the author of the book is ~w',[D]),nl,
                  format('The name of the book is ~w',[C]),
                  R is (Copies-Count),nl,
                  format('The amount of remaining copies are: ~w',[R]),nl.



























