alter table "public"."user_interests"
  add constraint "user_interests_interest_id_fkey"
  foreign key ("interest_id")
  references "public"."interests"
  ("id") on update cascade on delete cascade;
