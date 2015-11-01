
/* Create testRPC database if one does not exist and use it*/
create database if not exists rpc;

use rpc;

drop table if exists HasRole;
drop table if exists HasPosition;
drop table if exists Participates;
drop table if exists QualifierAdmins;
drop table if exists HostQualifiers;
drop table if exists Helps;
drop table if exists Hosts;
drop table if exists Manages;
drop table if exists Members;
drop table if exists Qualifiers;
drop table if exists VolunteerPositions;
drop table if exists ShirtSizes;
drop table if exists Competitions;
drop table if exists Coaches;
drop table if exists Volunteers;
drop table if exists Admins;
drop table if exists Teams;
drop table if exists Seasons;
drop table if exists Users;
DROP TABLE if exists responses;
DROP TABLE if exists sent_emails;


CREATE TABLE Users (
  user_id int(10) not null auto_increment,
  email varchar(128) not NULL unique,
  password varchar(128),
  api_token varchar(128) not NULL unique,  
  first_name varchar(128) not NULL,
  last_name varchar(128) not NULL,
  phone varchar(30),
  civic_number varchar(128),
  street1 varchar(128),
  street2 varchar(128),
  city varchar(128),
  province varchar(128),
  postal_code char(7),
  dob varchar(128),
  gender varchar(30),
  medical_info varchar(255),

  PRIMARY KEY (user_id)

)ENGINE=InnoDB auto_increment=100000 DEFAULT CHARSET=utf8;


CREATE TABLE Seasons (
  year varchar(128) not NULL,
  info varchar(255),
  status ENUM("open", "closed", "completed") DEFAULT "closed",
  
  PRIMARY KEY (year)

) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE Teams (
  team_id varchar(128) not null, 
  name varchar(255) unique not null,
  organization varchar(255) not null,
  approved boolean DEFAULT false,

  PRIMARY KEY (team_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE Admins (
  user_id int(10) not null,
  shirt_size varchar(255) not null,
  consent varchar(128) DEFAULT null,

  FOREIGN KEY (user_id)
      REFERENCES Users(user_id),

  PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QualifierAdmins (
  user_id int(10) not null,
  shirt_size varchar(255) not null,
  consent varchar(128) DEFAULT null,

  FOREIGN KEY (user_id)
      REFERENCES Users(user_id),

  PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Coaches (
  user_id int(10) not null,
  shirt_size varchar(255) not null,
  consent varchar(128) DEFAULT null,
  position ENUM("Main Coach", "Assistant Coach") DEFAULT null,

  FOREIGN KEY (user_id)
      REFERENCES Users(user_id),
  
  PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Volunteers (
  volunteer_id int(10) not null auto_increment,
  email varchar(128) not NULL,
  first_name varchar(128) not NULL,
  last_name varchar(128) not NULL,
  phone varchar(30),
  civic_number varchar(128),
  street1 varchar(128),
  street2 varchar(128),
  city varchar(128),
  province varchar(128),
  postal_code char(7),
  dob varchar(128),
  gender varchar(30),
  medical_info varchar(255),
  shirt_size varchar(255) not null,
  consent varchar(128) DEFAULT null,
  position varchar(255) not null,
  season_year varchar(128) not NULL,
  
  FOREIGN KEY (season_year)
      REFERENCES Seasons(year),

  PRIMARY KEY (volunteer_id, season_year)

) ENGINE=InnoDB auto_increment=100000 DEFAULT CHARSET=utf8;

CREATE TABLE Competitions (
  competition_id int(10) not NULL auto_increment,
  season_year varchar(128) not NULL,
  name varchar(128) not NULL,
  status ENUM("open", "closed", "completed") DEFAULT "closed",
  time varchar(128),
  phone varchar(30),
  civic_number varchar(128),
  street1 varchar(128),
  street2 varchar(128),
  city varchar(128),
  province varchar(128),
  postal_code char(7),
  capacity int(3) not NULL,
  FOREIGN KEY (season_year)
      REFERENCES Seasons(year),
  PRIMARY KEY (competition_id, season_year)

)ENGINE=InnoDB auto_increment=100000 DEFAULT CHARSET=utf8;

CREATE TABLE ShirtSizes(
  shirt_size varchar(128) not NULL,
  season_year varchar(128) not NULL,

  FOREIGN KEY (season_year)
      REFERENCES Seasons(year),

  PRIMARY KEY (shirt_size)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE VolunteerPositions(
  position_id int(10) not NULL auto_increment,
  position varchar(128) not NULL,

  PRIMARY KEY (position_id)
) ENGINE=InnoDB auto_increment=100000 DEFAULT CHARSET=utf8;

CREATE TABLE Qualifiers (
  qual_id int(10) not NULL auto_increment,
  competition_id int(10) not NULL,
  season_year varchar(128) not NULL,
  name varchar(128) not NULL,
  status ENUM("open", "closed", "completed") DEFAULT "closed",
  time varchar(128),
  phone varchar(30),
  civic_number varchar(128),
  street1 varchar(128),
  street2 varchar(128),
  city varchar(128),
  province varchar(128),
  postal_code char(7),
  capacity int(3),
  FOREIGN KEY (season_year)
      REFERENCES Competitions(season_year),
  FOREIGN KEY (competition_id)
      REFERENCES Competitions(competition_id),

  PRIMARY KEY (qual_id, competition_id, season_year)

)ENGINE=InnoDB auto_increment=100000 DEFAULT CHARSET=utf8;

CREATE TABLE Members (
  member_id int(10) not NULL auto_increment,
  team_id varchar(128) not NULL,
  email varchar(128) not NULL,
  first_name varchar(128),
  last_name varchar(128),
  civic_number varchar(128),
  street1 varchar(128),
  street2 varchar(128),
  city varchar(128),
  province varchar(128),
  postal_code char(7),
  dob varchar(128),
  gender varchar(30),
  shirt_size varchar(30),
  guardian_name varchar(128),
  guardian_email varchar(128),
  guardian_phone varchar(30),
  medical_info varchar(255),
  consent varchar(128), 

  FOREIGN KEY (team_id)
      REFERENCES Teams(team_id),

  PRIMARY KEY (member_id, team_id)

)ENGINE=InnoDB auto_increment=100000 DEFAULT CHARSET=utf8;



CREATE TABLE HostQualifiers (
  user_id int(10) not NULL,
  qual_id int(10) not NULL auto_increment,
  competition_id int(10) not NULL,
  season_year varchar(128) not NULL,
    
  FOREIGN KEY (user_id)
      REFERENCES Users(user_id),

  FOREIGN KEY (season_year)
      REFERENCES Qualifiers(season_year),

  FOREIGN KEY (competition_id)
      REFERENCES Qualifiers(competition_id),

  FOREIGN KEY (qual_id)
      REFERENCES Qualifiers(qual_id),

  PRIMARY KEY (user_id, qual_id, competition_id, season_year)

)ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE Hosts (
  user_id int(10) not NULL,
  season_year varchar(128) not NULL,
    
  FOREIGN KEY (user_id)
      REFERENCES Users(user_id),

  FOREIGN KEY (season_year)
      REFERENCES Seasons(year),

  PRIMARY KEY (user_id, season_year)

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Helps (
  qual_id int(10) not NULL,
  competition_id int(10) not NULL,
  season_year varchar(128) not NULL,
  volunteer_id int(10) not NULL,

  FOREIGN KEY (qual_id)
      REFERENCES Qualifiers(qual_id),

  FOREIGN KEY (competition_id)
      REFERENCES Competitions(competition_id),

  FOREIGN KEY (volunteer_id)
      REFERENCES Volunteers(volunteer_id),

  FOREIGN KEY (season_year)
      REFERENCES Seasons(year),
  
  PRIMARY KEY (qual_id, competition_id, season_year, volunteer_id)

)ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE Manages (
  `team_id` varchar(128) not NULL,
  `user_id` int(10) not NULL,

  FOREIGN KEY (`team_id`)
      REFERENCES Teams(`team_id`),

  FOREIGN KEY (`user_id`)
      REFERENCES Users(`user_id`),

  PRIMARY KEY (`team_id`, `user_id`)

)ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE Participates (
  qual_id int(10) not NULL,
  competition_id int(10) not NULL,
  team_id varchar(128) not NULL,
  season_year varchar(128) not NULL,
  local_id int(10) not null unique,

  FOREIGN KEY (qual_id)
      REFERENCES Qualifiers(qual_id),

  FOREIGN KEY (competition_id)
      REFERENCES Qualifiers(competition_id),

  FOREIGN KEY (team_id)
      REFERENCES Teams(team_id),

  FOREIGN KEY (season_year)
      REFERENCES Qualifiers(season_year),

  PRIMARY KEY (qual_id, team_id, competition_id, season_year)

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE HasRole (
  user_id int(10) not NULL,
  email varchar(128) not NULL unique,
  first_name varchar(128) not NULL,
  last_name varchar(128) not NULL,
  phone varchar(30),
  civic_number varchar(128),
  street1 varchar(128),
  street2 varchar(128),
  city varchar(128),
  province varchar(128),
  postal_code char(7),
  dob varchar(128),
  gender varchar(30),
  medical_info varchar(128),
  shirt_size varchar(128),
  consent varchar(128),
  position ENUM("Admin", "Qualifier Admin", "Main Coach", "Assistant Coach")  DEFAULT null,
  admin boolean not null DEFAULT false, 
  qualifier_admin boolean not null DEFAULT false,
  coach boolean not null DEFAULT false,


  PRIMARY KEY (user_id)

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE HasPosition (
  volunteer_id int(10) not null,
  position_id int(10) not null,

  FOREIGN KEY (volunteer_id)
      REFERENCES Volunteers(volunteer_id),

  FOREIGN KEY (position_id)
      REFERENCES VolunteerPositions(position_id),

  PRIMARY KEY (volunteer_id, position_id)

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE responses (
  reset_key char(32) NOT NULL,
  secret char(60) NOT NULL,
  request_timestamp datetime NOT NULL,
  request_ip varchar(39) NOT NULL,
  email_address char(64) NOT NULL,
  used tinyint(1) NOT NULL DEFAULT '0',
  active tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (reset_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE sent_emails (
  email_address char(64) NOT NULL,
  timestamp datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;