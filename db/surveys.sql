use rpc;

drop table if exists AudienceSurveys;
drop table if exists CoachSurveys;
drop table if exists VolunteerSurveys;
drop table if exists StudentSurveys;


CREATE TABLE AudienceSurveys (
  survey_id int(10) not null auto_increment,
  year int(10) not null,
  town varchar(128),
  heard_from varchar(128),

  viewing_exp int(2),
  hearing_exp int(2),
  food_exp int(2),
  venue_exp int(2),
  displays_exp int(2),
  return_next_year int(2),
  overall_enjoyment int(2),

  attendence_cause varchar(128),
  comments varchar(255),

  PRIMARY KEY (survey_id, year)
)ENGINE=InnoDB auto_increment=100000 DEFAULT CHARSET=utf8;

CREATE TABLE CoachSurveys (
  survey_id int(10) not null auto_increment,
  year int(10) not null,

  affiliation varchar(128),
  paricipation_years varchar(128),
  heard_from varchar(128),

  cost int(2),
  preperation_time int(2),
  webpage_exp int(2),
  learning_exp int(2),
  interest_in_science int(2),
  schedule_exp int(2),
  food_exp int(2),
  return_next_year int(2),
  overall_enjoyment int(2),

  most_liked varchar(128),
  comments varchar(255),

  PRIMARY KEY (survey_id, year)
)ENGINE=InnoDB auto_increment=100000 DEFAULT CHARSET=utf8;

CREATE TABLE VolunteerSurveys (
  survey_id int(10) not null auto_increment,
  year int(10) not null,

  affiliation varchar(128),

  training_exp int(2),
  webpage_exp int(2),
  schedule_exp int(2),
  food_exp int(2),
  email_communication int(2),
  communication_exp int(2),
  overall_enjoyment int(2),

  most_liked varchar(128),
  comments varchar(255),

  PRIMARY KEY (survey_id, year)
)ENGINE=InnoDB auto_increment=100000 DEFAULT CHARSET=utf8;

CREATE TABLE StudentSurveys (
  survey_id int(10) not null auto_increment,
  year int(10) not null,

  affiliation varchar(128),
  paricipation_years int(10),
  gender varchar(128),
  heard_from varchar(128),
  changes_to_website varchar(255),

  programming_learning_exp int(2),
  teamwork_learning_exp int(2),
  schedule_exp int(2),
  food_exp int(2),
  programming_interest_increase int(2),
  science_interest_increase int(2),
  science_carrer_consideration int(2),
  return_next_year int(2),
  overall_enjoyment int(2),

  most_liked varchar(128),
  comments varchar(255),

  PRIMARY KEY (survey_id, year)
)ENGINE=InnoDB auto_increment=100000 DEFAULT CHARSET=utf8;