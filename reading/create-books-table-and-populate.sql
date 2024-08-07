create table polish.books (
  bookid serial,
  title text,
  author text,
  publisher text,
  publish_year text,
  source text,
  genre text,
  pages int,
  finished bool,
  impression text,
  opinion text,
  start_year text,
  start_date date,
  end_date date
);

insert into polish.books (title, author, publisher, publish_year, source, genre, pages, finished)
values
  ('Dolina Issy', 'Czeslaw Milosz', 'Wydawnictwo Literackie', '2016', 'borrowed', 'Fiction', 256, false),
  ('Eseje dla Kassandry', 'Jerzy Stempowski', 'Biblioteka WIEZI', '', 'library', 'Essays', 319, false),
  ('Odrzania', 'Zbigniew Rokita', 'Znak', '2023', 'purchased', 'Non-Fiction', 282, false),
  ('Ostatnie Rozdanie', 'Wieslaw Mysliwski', 'Znak', '2019', 'purchased', 'Fiction', 400, false),
  ('Filozoficzny Lem', 'Stanislaw Lem', 'Aletheia', '2021', 'library', 'Essays', 428, false),
  ('Proza Wybrana', 'Leo Lipski', 'Wydawnictwo Zarne', '2022', 'purchased', 'Fiction', 402, false),
  ('Cholod', 'Szczepan Twardoch', 'Wydawnictwo Literackie', '2022', 'purchased', 'Fiction', 446, false),
  ('Sol Ziemi', 'Jozef Witlin', 'Instytut Literatury', '2022', 'purchased', 'Fiction', 380, false),
  ('Wszystkie kroniki wina', 'Marek Bienczyk', 'Wielka Litera', '2018', 'purchased', 'Essays', 679, false),
  ('Kiwka', 'Michal Pawel Markowski', 'Austeria', '2015', 'purchased', 'Essays', 253, false),
  ('Weiser Dawidek', 'Pawel Huelle', 'Wydawnictwo Znak', '2008', 'gift', 'Fiction', 263, false),
  ('Babel Czlowiek bez losu', 'Aleksander Kaczorowski', 'Wydawnictwo Zarne', '2023', 'purchased', 'Biography', 287, false),
  ('Trzecie klamstwo', 'Kazimierz Orlos', 'Wydawnictwo Literackie', '2022', 'purchased', 'Fiction', 353, false),
  ('Salki', 'Wojciech Nowicki', 'Wydawnictwo Zarne', '2013', 'gift', 'Non-Fiction', 212, false),
  ('Mury Hebronu', 'Andrzej Stasiuk', 'Wydawnictwo Zarne', '2016', 'purchased', 'Fiction', 155, false),
  ('Wielkie Rozczarowanie', 'Marcin Zaremba', 'Znak Horyzont', '2023', 'purchased', 'History', 681, false),
  ('Cywilizacja Slowian', 'Kamil Janicki', 'Wydawnictwo Poznanskie', '2023', 'purchased', 'History', 325, false),
  ('Pax Romana', 'Adrian Goldsworthy', 'Dom Wydawniczy Rebis', '2017', 'purchased', 'History', 462, false),
  ('Boze Igrzysko. Tom I', 'Norman Davies', 'Znak Historia', '2018', 'purchased', 'History', 483, false),
  ('Boze Igrzysko. Tom II', 'Norman Davies', 'Znak Historia', '2018', 'purchased', 'History', 635, false),
  ('Oktawian August. Ojciec Chrzestny Europy', 'Richard Holland', 'Amber', '2019', 'purchased', 'History', 324, false),
  ('Wojna Peloponeska', 'Tukidydes', 'Spoldzielnia Wydawnicza Czytelnik', '2023', 'purchased', 'History', 518, false),
  ('Dzieje', 'Herodot', 'Spoldzielnia Wydawnicza Czytelnik', '2020', 'purchased', 'History', 542, false),
  ('Upadek Kartaginy', 'Adrian Goldsworthy', 'Dom Wydawniczy Rebis', '2020', 'purchased', 'History', 419, false),
  ('Nie tylko pod Salamina', 'Waldemar Pasiut', 'Wydawnictwo Tetragon', '2015', 'purchased', 'History', 320, false),
  ('Thomas Cromwell', 'Tracy Borman', 'Wydawnictwo Astra', '2016', 'purchased', 'Biography', 421, false),
  ('Poncjusz Pilat', 'Ann Wroe', 'Grupa Wydawnicza Foksal', '1999', 'purchased', 'Biography', 425, false),
  ('Pierwsza Wojna Swiatowa', 'Janusz Pajewski', 'Panstwowe Wydawnictwo Naukowe PWN', '2014', 'purchased', 'History', 769, false),
  ('Basn o wezowym sercu albo wtore slowo o Jakobie Szeli', 'Radek Rak', 'Powergraph', '2021', 'Purchased', 'Fiction', 435, false),
  ('Kamien na kamieniu', 'Wieslaw Mysliwski', 'Wydawnictwo Znak', '2019', 'purchased', 'Fiction', 514, false)