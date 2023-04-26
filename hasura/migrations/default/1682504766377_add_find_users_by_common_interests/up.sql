-- Create a function named 'find_users_by_common_interests'
-- It takes an input parameter 'input_user_id' of type INTEGER
-- The function returns a set of rows from the 'users' table
CREATE OR REPLACE FUNCTION public.find_users_by_common_interests(input_user_id INTEGER)
RETURNS SETOF users
LANGUAGE sql
STABLE
AS $function$

SELECT
    u.* -- Select all columns from the 'users' table and give the table an alias 'u'
FROM
    users u
WHERE
    u.id <> input_user_id -- Filter out the user with the same ID as the input user
ORDER BY
    (
        -- Subquery to calculate the number of common interests between input user and other users
        SELECT
            COUNT(*) -- Count the number of common interests between the two users
        FROM
            user_interests ui1 -- Aliased 'user_interests' table for the input user
            JOIN user_interests ui2 ON ui1.interest_id = ui2.interest_id -- Inner join on 'user_interests' table to find matching interests between input user and other users
        WHERE
            ui1.user_id = input_user_id -- Filter the joined table to include only rows where 'ui1.user_id' matches the input user ID
            AND ui2.user_id = u.id -- Filter the joined table to include only rows where 'ui2.user_id' matches the ID of the user being compared
    ) DESC; -- Sort the result in descending order based on the number of common interests

$function$;
