/*
 Table: Activity
 
 +--------------+---------+
 | Column Name  | Type    |
 +--------------+---------+
 | player_id    | int     |
 | device_id    | int     |
 | event_date   | date    |
 | games_played | int     |
 +--------------+---------+
 (player_id, event_date) is the primary key (combination of columns with unique values) of this table.
 This table shows the activity of players of some games.
 Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 
 
 Write a solution to find the first login date for each player.
 
 Return the result table in any order.
 
 The result format is in the following example.
 
 
 
 Example 1:
 
 Input: Activity table:
 +-----------+-----------+------------+--------------+
 | player_id | device_id | event_date | games_played |
 +-----------+-----------+------------+--------------+
 | 1         | 2         | 2016-03-01 | 5            |
 | 1         | 2         | 2016-05-02 | 6            |
 | 2         | 3         | 2017-06-25 | 1            |
 | 3         | 1         | 2016-03-02 | 0            |
 | 3         | 4         | 2018-07-03 | 5            |
 +-----------+-----------+------------+--------------+
 Output: 
 +-----------+-------------+
 | player_id | first_login |
 +-----------+-------------+
 | 1         | 2016-03-01  |
 | 2         | 2017-06-25  |
 | 3         | 2016-03-02  |
 +-----------+-------------+
 
 
 */
-- Create table query
CREATE TABLE Activity
(
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);

-- Insert data query
INSERT INTO
    Activity
    (player_id, device_id, event_date, games_played)
VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);

select
    *
from
    Activity a 
    
-- solution -- 
--1)
GO
select
    *
from
    (
        select
        -- a.*,
        a.player_id,
        min(a.event_date) over (partition by player_id) as first_login
    from
        Activity a
    group by
            a.player_id,
            a.event_date
    ) x
group by
    x.player_id,
    x.first_login 
    
    
--2
GO
with
    result
    as
    (
        select
            player_id,
            event_date as first_login,
            dense_rank() over(
                partition by player_id
                order by
                    event_date
            ) as rnk
        from
            Activity
    )
select
    player_id,
    first_login
from
    result
where
    rnk = 1


    

--3

select player_id,min(event_date) as first_login from Activity group by player_id