from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import (scoped_session, sessionmaker,
                            backref, relationship)
from sqlalchemy import (Column, DateTime, ForeignKey,
						Integer, String, Boolean, Float,
						func, BigInteger)
from sqlalchemy import UniqueConstraint

import sys
import os

from dotenv import load_dotenv, find_dotenv
dotenv_path = find_dotenv()
load_dotenv(dotenv_path)


engine = create_engine(os.environ.get("DATABASE_URL"))

Base = declarative_base()
Base.metadata.bind = engine

class Films(Base):
    __tablename__ = 'films'

    id = Column(Integer, primary_key=True, unique=True, autoincrement=True)
    title = Column(String, primary_key=True)
    wiki_href = Column(String)

class FilmsOMDB(Base):
    __tablename__ = 'films_omdb'

    id = Column(Integer, primary_key=True)

    # film information

    title = Column(String)
    year = Column(Integer)
    rated = Column(String)
    released = Column(DateTime)
    runtime = Column(Integer)
    
    genres = relationship(
        "Genres",
        secondary="film_genres"
    )

    plot = Column(String)

    oscar_wins = Column(Integer)
    oscar_noms = Column(Integer)
    award_wins = Column(Integer)
    award_noms = Column(Integer)

    ratings_tomatoes = Column(Integer)
    ratings_meta = Column(Integer)
    ratings_imdb = Column(Float)

    dvd_release = Column(DateTime)
    box_office = Column(Integer)

### wikipedia core

class FilmsWiki(Base):
    __tablename__ = 'films_wiki'

    id = Column(Integer, ForeignKey('films.id'), primary_key=True)
    film = relationship("Films", backref=backref("film_id"))

    title = Column(String, nullable=False)
    released = Column(DateTime)
    running_time = Column(Integer)
    budget = Column(Integer)
    box_office = Column(Integer)
    
    persons = relationship(
        "Persons",
        secondary="film_persons"
    )

    countries = relationship(
        "Countries",
        secondary="film_countries"
    )

    companies = relationship(
        "Companies",
        secondary="film_companies"
    )

    languages = relationship(
        "Languages",
        secondary="film_languages"
    )

class Persons(Base):
    __tablename__ = 'persons'

    id = Column(Integer, primary_key=True)
    full_name = Column(String)
    films = relationship(
        "FilmsWiki",
        secondary="film_persons"
        )

class FilmPersons(Base):
    
    __tablename__ = 'film_persons'
    # people by film
    film_id = Column(Integer, ForeignKey('films_wiki.id'), primary_key=True)
    film = relationship("FilmsWiki", backref=backref("film_person"))
    person_id = Column(Integer, ForeignKey('persons.id'), primary_key=True)
    person = relationship("Persons", backref=backref("person_film"))
    role = Column(String, primary_key=True)

class Countries(Base):

    __tablename__ = 'countries'
    id = Column(Integer, primary_key=True)
    country = Column(String)
    films = relationship(
        "FilmsWiki",
        secondary="film_countries"
        )

class FilmCountries(Base):

    __tablename__ = 'film_countries'
    film_id = Column(Integer, ForeignKey('films_wiki.id'), primary_key=True)
    film = relationship("FilmsWiki", backref=backref("film_country"))
    country_id = Column(Integer, ForeignKey('countries.id'), primary_key=True)
    country = relationship("Countries", backref=backref("country_film"))

class Companies(Base):

    __tablename__ = 'companies'
    id = Column(Integer, primary_key=True)
    company = Column(String, nullable=False)
    films = relationship(
        "FilmsWiki",
        secondary="film_companies"
        )

class FilmCompanies(Base):

    __tablename__ = 'film_companies'
    film_id = Column(Integer, ForeignKey('films_wiki.id'), primary_key=True)
    film = relationship("FilmsWiki", backref=backref("film_company"))
    company_id = Column(Integer, ForeignKey('companies.id'), primary_key=True)
    company = relationship("Companies", backref=backref("company_film"))
    role = Column(String, primary_key=True)

class Languages(Base):

    __tablename__ = 'languages'
    id = Column(Integer, primary_key=True)
    language = Column(String)
    films = relationship(
        "FilmsWiki",
        secondary="film_languages"
        )

class FilmLanguages(Base):

    __tablename__ = 'film_languages'
    film_id = Column(Integer, ForeignKey('films_wiki.id'), primary_key=True)
    film = relationship("FilmsWiki", backref=backref("film_language"))
    language_id = Column(Integer, ForeignKey('languages.id'), primary_key=True)
    language = relationship("Languages", backref=backref("language_film"))

class Genres(Base):

    __tablename__ = 'genres'
    id = Column(Integer, primary_key=True)
    genre = Column(String)
    films = relationship(
        "FilmsOMDB",
        secondary="film_genres"
        )

class FilmGenres(Base):

    __tablename__ = 'film_genres'
    film_id = Column(Integer, ForeignKey('films_omdb.id'), primary_key=True)
    film = relationship("FilmsOMDB", backref=backref("film_genre"))
    genre_id = Column(Integer, ForeignKey('genres.id'), primary_key=True)
    genre = relationship("Genres", backref=backref("genre_film"))

class HolidaysUSA(Base):

    __tablename__ = 'usa_holidays'
    date = Column(DateTime, primary_key=True)
    holiday = Column(String, primary_key=True)

class MojoSummary(Base):

    __tablename__ = 'mojo_summary'
    id = Column(Integer, ForeignKey('films_wiki.id'), primary_key=True)
    film = relationship("FilmsWiki", backref=backref("film_mojo"))
    domestic_gross = Column(Integer)
    foreign_gross = Column(Integer)
    budget = Column(Integer)


class MojoDaily(Base):

    __tablename__ = 'mojo_daily'
    date = Column(DateTime, primary_key=True)
    id = Column(Integer, ForeignKey('films_wiki.id'), primary_key=True)
    film = relationship("FilmsWiki", backref=backref("film_daily"))

    day = Column(String)
    rank = Column(Integer)
    gross = Column(Integer)
    num_theatres = Column(Integer)
    num_day = Column(Integer)

def init_db():
    Base.metadata.create_all(bind=engine)

if __name__ == "__main__":
    
    init_db()
    for table in Base.metadata.tables.keys():
        response = input("Drop {}? [y]".format(table))
        if response == 'y':
            engine.execute("DROP TABLE %s CASCADE;" % table)
            print("Dropped {}".format(table))
    
    reponse = input("Create all tables? [y]")
    if reponse == 'y':
        print("Creating database")
        init_db()