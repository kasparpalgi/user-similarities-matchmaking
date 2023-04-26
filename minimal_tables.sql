CREATE TABLE "users"(
    "id" INTEGER NOT NULL,
    "first_name" TEXT NOT NULL
);
ALTER TABLE
    "users" ADD PRIMARY KEY("id");
CREATE TABLE "user_interests"(
    "id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "interest_id" INTEGER NOT NULL
);
ALTER TABLE
    "user_interests" ADD PRIMARY KEY("id");
CREATE TABLE "interests"(
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL
);
ALTER TABLE
    "interests" ADD PRIMARY KEY("id");
ALTER TABLE
    "user_interests" ADD CONSTRAINT "user_interests_interest_id_foreign" FOREIGN KEY("interest_id") REFERENCES "interests"("id");
ALTER TABLE
    "user_interests" ADD CONSTRAINT "user_interests_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");