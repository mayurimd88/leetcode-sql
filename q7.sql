create table players (player_id int, group_id int); 
insert into players values (15,1), (25,1), (30,1), (45,1),(10,2), (35,2), (50,2), (20,3), (40,3); 
create table matches ( match_id int, first_player int, second_player int, first_score int, second_score int); 
insert into matches values (1,15,45,3,0), (2,30,25,1,2),  (3,30,15,2,0), (4,40,20,5,2), (5,35,50,1,1);

/* find the winner in each group.
winner in each group is the player who scored 
max total points within the group.
in case of tie, lowest player_id wins. */

SELECT * FROM players;
SELECT * FROM matches;

WITH player_scores AS
(	SELECT first_player AS player_id, first_score AS score FROM matches
    UNION ALL
    SELECT second_player AS player_id, second_score AS score FROM matches
),
final_scores AS
(	SELECT p.group_id, ps.player_id, SUM(score) AS score
    FROM player_scores ps
    INNER JOIN players p ON p.player_id = ps.player_id
    GROUP BY p.group_id, ps.player_id
),
final_ranking AS
(	SELECT *,
    RANK() OVER(PARTITION BY group_id ORDER BY score DESC, player_id ASC) AS rn
    FROM final_scores
)
SELECT * FROM final_ranking WHERE rn = 1;