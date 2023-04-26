
alter table "public"."user_interests" drop constraint "user_interests_interest_id_fkey";

alter table "public"."user_interests" drop constraint "user_interests_user_id_fkey";

DROP TABLE "public"."user_interests";

comment on column "public"."interests"."name" is NULL;

DROP TABLE "public"."interests";

DROP TABLE "public"."users";
