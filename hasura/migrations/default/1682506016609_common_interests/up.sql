-- Create a function named 'common_interests'
-- It takes two input parameters:
-- 'user_row' of type 'users' (a row from the 'users' table)
-- 'input' of type JSON, which should contain a key 'user_id' with a user ID value
CREATE OR REPLACE FUNCTION public.common_interests(user_row users, input JSON)
RETURNS SETOF interests -- Returns a set of rows from the 'interests' table
LANGUAGE sql
STABLE
AS $function$

SELECT
    i.* -- Select all columns from the 'interests' table and give the table an alias 'i'
FROM
    interests i
    -- Join the 'interests' table with 'user_interests' for the target user (input user)
    JOIN user_interests target_user_interests ON i.id = target_user_interests.interest_id
    -- Join the 'interests' table with 'user_interests' for the other user (user_row)
    JOIN user_interests other_user_interests ON i.id = other_user_interests.interest_id
WHERE
    -- Filter the joined tables to include only rows where 'target_user_interests.user_id' matches the input user ID
    target_user_interests.user_id = (input ->> 'user_id') :: INTEGER
    -- Filter the joined tables to include only rows where 'other_user_interests.user_id' matches the ID of the user being compared
    AND other_user_interests.user_id = user_row.id;

$function$;