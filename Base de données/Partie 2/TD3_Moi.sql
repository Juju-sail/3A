-- Question 1
create table acteurs(
    id_acteur int(4) not null,
    prenom varchar(20) not null,
    nom varchar(20) not null
    )

--Question 2 
alter table acteurs
add constraint pk_acteurs
primary key {id_acteur}

--Avant question 3
alter table acteurs
change id_acteur id_acteur int auto_increment

--Question 3
insert into acteurs (prenom, nom)
values("Kristen", "Bell")
.
.
.

--Question 4
create table films(
	id_film int auto_increment,
	primary key titre varchar(40),
	date_sortie date
	)

--Question 5
insert into films (titre, date_sortie)
values ("veronica mars", "2017-03-08")
.
.
.

--Question 6 
create table roles(
	id_acteur int,
	id_film int,
	nom_complet_perso varchar(40),
	primary key (id_acteur, id_film),
	foreign key (id_acteur) references acteurs(id_acteur) on delete cascade on update cascade,
	foreign key (id_film) references films(id_film) on delete cascade on update cascade
	)

--Question 7 
insert into roles values(1,1,"Veronica mars")	
.
.
.

--Question 8 
update films
set date_sortie = "2016-12-28"
where titre = "Paterson"

--Question 9
alter table acteurs
add date_naissance date






