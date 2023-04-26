
CREATE TABLE "public"."users" ("id" serial NOT NULL, "first_name" text NOT NULL, PRIMARY KEY ("id") );

CREATE TABLE "public"."interests" ("id" serial NOT NULL, "name" text NOT NULL, PRIMARY KEY ("id") );

comment on column "public"."interests"."name" is E'Name of the interest. Eg. "Programming" or "Hasura"';

CREATE TABLE "public"."user_interests" ("id" serial NOT NULL, "user_id" integer NOT NULL, "interest_id" integer NOT NULL, PRIMARY KEY ("id") );

alter table "public"."user_interests"
  add constraint "user_interests_user_id_fkey"
  foreign key ("user_id")
  references "public"."users"
  ("id") on update cascade on delete cascade;

alter table "public"."user_interests"
  add constraint "user_interests_interest_id_fkey"
  foreign key ("interest_id")
  references "public"."interests"
  ("id") on update cascade on delete cascade;
