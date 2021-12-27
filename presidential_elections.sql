-- created a table
CREATE TABLE presidential_election_ (
	year_	int4,
	state_	varchar (20),
	state_po	varchar(2),
	candidate	text,
	party_detailed	varchar,
	candidate_vote	int
);
-- to see the data output
SELECT * FROM presidential_election_;

--to get the total number of candidate and the year in which they run for election
SELECT DISTINCT candidate, year_ FROM presidential_election_
ORDER BY candidate ASC;

SELECT year_,
	state_,
	candidate,
	candidate_vote
FROM presidential_election_
-- added a space because in the file, data have a space in front of them
WHERE candidate = 'RONALD REAGAN'

--to calculate the candidate with the highest vote ever with the state
SELECT DISTINCT candidate,
	state_,
	candidate_vote,
	year_
FROM presidential_election_
WHERE candidate_vote = (SELECT MAX(candidate_vote) FROM presidential_election_);

--to calculate the candidate with the lowest value
SELECT DISTINCT candidate,
	state_,
	candidate_vote,
	year_
FROM presidential_election_
WHERE candidate_vote = (SELECT MIN(candidate_vote) FROM presidential_election_);

-- to calculate candidate with votes higher than 3 million votes
SELECT DISTINCT candidate,
	state_,
	candidate_vote,
	year_
FROM presidential_election_
WHERE candidate_vote > 3000000
ORDER BY year_

--to calculate the state with the lowest vote for each election year, per state and the candidate
SELECT state_,
	year_,
	candidate,
	candidate_vote
FROM presidential_election_
WHERE candidate_vote < 40
ORDER BY candidate_vote

--to calculate the total vote per candidate for each election year and identify the winner
SELECT DISTINCT candidate,year_,
SUM(candidate_vote)AS total_Vote
FROM presidential_election_
WHERE year_=2012
GROUP BY candidate,year_
ORDER BY total_Vote DESC;

SELECT candidate,candidate_vote,state_,
SUM(candidate_vote)AS total_Vote
FROM presidential_election_
WHERE year_=1980
GROUP BY candidate,candidate_vote,state_
ORDER BY Candidate DESC;

SELECT candidate, (total/total_vote)*100 AS vote_percent,FROM presidential_election;




