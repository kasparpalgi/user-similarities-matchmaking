-- Create a function named 'other_interests'
-- It takes two input parameters:
-- 'user_row' of type 'users' (a row from the 'users' table)
-- 'input' of type JSON, which should contain a key 'user_id' with a user ID value
-- The function returns a set of rows from the 'interests' table
CREATE OR REPLACE FUNCTION public.other_interests(user_row users, input json)
RETURNS SETOF interests
LANGUAGE sql
STABLE
AS $function$

  SELECT i.* -- Select all columns from the 'interests' table and give the table an alias 'i'
  FROM interests i
  -- Join the 'interests' table with 'user_interests' for the other user (other_user_interests)
  JOIN user_interests other_user_interests ON i.id = other_user_interests.interest_id
  WHERE
    -- Filter the joined tables to include only rows where 'other_user_interests.user_id' matches the ID of the user being compared
    other_user_interests.user_id = user_row.id
    -- Exclude rows with interest IDs that are also present in the 'user_interests' table for the input user
    AND i.id NOT IN (
      SELECT interest_id
      FROM user_interests
      -- Filter the 'user_interests' table to include only rows where 'user_id' matches the input user ID
      WHERE user_id = (input->>'user_id')::INTEGER
    );

$function$;
