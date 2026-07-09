-- Create "systemparameters" table
CREATE TABLE "public"."systemparameters" (
  "id" serial NOT NULL,
  "name" text NOT NULL,
  "value" text NOT NULL,
  "shouldshowtoapp" boolean NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "systemparameters_name_key" UNIQUE ("name")
);
-- Create "users" table
CREATE TABLE "public"."users" (
  "id" serial NOT NULL,
  "login" text NOT NULL,
  "displayname" text NULL,
  "email" text NOT NULL,
  "password" text NOT NULL,
  "joindate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("id"),
  CONSTRAINT "users_displayname_key" UNIQUE ("displayname"),
  CONSTRAINT "users_email_key" UNIQUE ("email"),
  CONSTRAINT "users_login_key" UNIQUE ("login")
);
-- Create "wheeleffects" table
CREATE TABLE "public"."wheeleffects" (
  "id" serial NOT NULL,
  "name" text NOT NULL,
  "description" text NOT NULL,
  PRIMARY KEY ("id")
);
-- Create "wheeleffecthistory" table
CREATE TABLE "public"."wheeleffecthistory" (
  "id" serial NOT NULL,
  "userid" integer NOT NULL,
  "wheeleffectid" integer NOT NULL,
  "rolldate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("id"),
  CONSTRAINT "wheeleffecthistory_userid_fkey" FOREIGN KEY ("userid") REFERENCES "public"."users" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "wheeleffecthistory_wheeleffectid_fkey" FOREIGN KEY ("wheeleffectid") REFERENCES "public"."wheeleffects" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- Create "freepointhistory" table
CREATE TABLE "public"."freepointhistory" (
  "id" serial NOT NULL,
  "userid" integer NOT NULL,
  "sourceuserid" integer NOT NULL,
  "changesource" text NOT NULL,
  "changevalue" integer NOT NULL,
  "actualchangevalue" integer NOT NULL,
  "finalvalue" integer NOT NULL,
  "wheeleffecthistoryid" integer NULL,
  "changedate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("id"),
  CONSTRAINT "freepointhistory_sourceuserid_fkey" FOREIGN KEY ("sourceuserid") REFERENCES "public"."users" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "freepointhistory_userid_fkey" FOREIGN KEY ("userid") REFERENCES "public"."users" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "freepointhistory_wheeleffecthistoryid_fkey" FOREIGN KEY ("wheeleffecthistoryid") REFERENCES "public"."wheeleffecthistory" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "freepointhistory_finalvalue_check" CHECK (finalvalue >= 0)
);
-- Create "games" table
CREATE TABLE "public"."games" (
  "id" serial NOT NULL,
  "name" text NOT NULL,
  "createdate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("id"),
  CONSTRAINT "games_name_key" UNIQUE ("name")
);
-- Create "gamehistory" table
CREATE TABLE "public"."gamehistory" (
  "id" serial NOT NULL,
  "userid" integer NOT NULL,
  "gameid" integer NOT NULL,
  "state" text NOT NULL DEFAULT 'started',
  "startdate" timestamp NOT NULL DEFAULT now(),
  "finishdate" timestamp NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "gamehistory_gameid_fkey" FOREIGN KEY ("gameid") REFERENCES "public"."games" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "gamehistory_userid_fkey" FOREIGN KEY ("userid") REFERENCES "public"."users" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- Create "lastwheeleffects" table
CREATE TABLE "public"."lastwheeleffects" (
  "id" serial NOT NULL,
  "userid" integer NOT NULL,
  "wheeleffectid" integer NOT NULL,
  "position" integer NOT NULL,
  "isapplied" integer NOT NULL DEFAULT 0,
  "rolldate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("id"),
  CONSTRAINT "lastwheeleffects_userid_fkey" FOREIGN KEY ("userid") REFERENCES "public"."users" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "lastwheeleffects_wheeleffectid_fkey" FOREIGN KEY ("wheeleffectid") REFERENCES "public"."wheeleffects" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "lastwheeleffects_isapplied_check" CHECK (isapplied = ANY (ARRAY[0, 1]))
);
-- Create "territorypointhistory" table
CREATE TABLE "public"."territorypointhistory" (
  "id" serial NOT NULL,
  "userid" integer NOT NULL,
  "sourceuserid" integer NOT NULL,
  "changesource" text NOT NULL,
  "changevalue" integer NOT NULL,
  "actualchangevalue" integer NOT NULL,
  "finalvalue" integer NOT NULL,
  "changedate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("id"),
  CONSTRAINT "territorypointhistory_sourceuserid_fkey" FOREIGN KEY ("sourceuserid") REFERENCES "public"."users" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "territorypointhistory_userid_fkey" FOREIGN KEY ("userid") REFERENCES "public"."users" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "territorypointhistory_finalvalue_check" CHECK (finalvalue >= 0)
);
-- Create "timers" table
CREATE TABLE "public"."timers" (
  "id" serial NOT NULL,
  "userid" integer NOT NULL,
  "gameid" integer NOT NULL,
  "state" text NOT NULL DEFAULT 'created',
  "durationins" integer NOT NULL,
  "remainingtimeins" integer NOT NULL,
  "createdate" timestamp NOT NULL DEFAULT now(),
  "lastactiondate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("id"),
  CONSTRAINT "timers_gameid_fkey" FOREIGN KEY ("gameid") REFERENCES "public"."games" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "timers_userid_fkey" FOREIGN KEY ("userid") REFERENCES "public"."users" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- Create "usersessions" table
CREATE TABLE "public"."usersessions" (
  "id" text NOT NULL,
  "userid" integer NOT NULL,
  "createdate" timestamp NOT NULL DEFAULT now(),
  "expirydate" timestamp NOT NULL DEFAULT (now() + '1 day'::interval),
  PRIMARY KEY ("id"),
  CONSTRAINT "usersessions_userid_fkey" FOREIGN KEY ("userid") REFERENCES "public"."users" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- Create "userstats" table
CREATE TABLE "public"."userstats" (
  "id" serial NOT NULL,
  "userid" integer NOT NULL,
  "availablerolls" integer NOT NULL DEFAULT 0,
  "territoryhours" integer NOT NULL DEFAULT 0,
  "experiencepoints" integer NOT NULL DEFAULT 0,
  "territorypoints" integer NOT NULL DEFAULT 0,
  "freepoints" integer NOT NULL DEFAULT 0,
  PRIMARY KEY ("id"),
  CONSTRAINT "userstats_userid_key" UNIQUE ("userid"),
  CONSTRAINT "userstats_userid_fkey" FOREIGN KEY ("userid") REFERENCES "public"."users" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- Create "wishlistgames" table
CREATE TABLE "public"."wishlistgames" (
  "id" serial NOT NULL,
  "userid" integer NOT NULL,
  "gameid" integer NOT NULL,
  "createdate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("id"),
  CONSTRAINT "wishlistgames_gameid_fkey" FOREIGN KEY ("gameid") REFERENCES "public"."games" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "wishlistgames_userid_fkey" FOREIGN KEY ("userid") REFERENCES "public"."users" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
