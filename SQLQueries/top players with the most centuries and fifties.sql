/* Who are the top players with the most centuries and fifties? */


select player_batting_id, Name,
sum(hundreds) as total_hundreds,
sum(fifties) as total_fifties,
sum(zeros) as total_zeros,
sum(fours) as total_fours,
sum(sixes) as total_sixes
from psl.batting
group by player_batting_id
ORDER BY total_fifties DESC;


select player_batting_id, Name,
sum(hundreds) as total_hundreds,sum(fifties) as total_fifties
from psl.batting
group by player_batting_id
ORDER BY total_hundreds DESC,total_fifties desc
