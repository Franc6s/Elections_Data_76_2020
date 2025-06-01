-- 1. Create the table
CREATE TABLE presidential_election_ (
    year_ INT,
    state_ VARCHAR(50),
    state_po VARCHAR(2),
    candidate TEXT,
    party_detailed VARCHAR(100),
    candidate_vote INT
);

-- 2. Preview data
SELECT * FROM presidential_election_ LIMIT 100;

-- 3. Get distinct candidates and the years they ran
SELECT DISTINCT candidate, year_
FROM presidential_election_
WHERE candidate IS NOT NULL
ORDER BY candidate, year_;

-- 4. All results for a specific candidate (example: Ronald Reagan)
SELECT year_,
       state_,
       candidate,
       candidate_vote
FROM presidential_election_
WHERE TRIM(candidate) = 'RONALD REAGAN'
ORDER BY year_, state_;

-- 5. Candidate with the highest vote ever (single state/year)
SELECT candidate,
       state_,
       candidate_vote,
       year_
FROM presidential_election_
WHERE candidate_vote = (
    SELECT MAX(candidate_vote) FROM presidential_election_
)
ORDER BY year_ DESC;

-- 6. Candidate with the lowest vote ever (excluding 0s/nulls)
SELECT candidate,
       state_,
       candidate_vote,
       year_
FROM presidential_election_
WHERE candidate_vote = (
    SELECT MIN(candidate_vote) FROM presidential_election_
    WHERE candidate_vote > 0
)
ORDER BY year_;

-- 7. Candidates with more than 3 million votes in a state
SELECT candidate,
       state_,
       candidate_vote,
       year_
FROM presidential_election_
WHERE candidate_vote > 3000000
ORDER BY year_, candidate_vote DESC;

-- 8. Extremely low votes per candidate (< 40)
SELECT state_,
       year_,
       candidate,
       candidate_vote
FROM presidential_election_
WHERE candidate_vote < 40
ORDER BY candidate_vote ASC, year_;

-- 9. Total votes per candidate in a specific year (e.g., 2012)
SELECT candidate,
       year_,
       SUM(candidate_vote) AS total_vote
FROM presidential_election_
WHERE year_ = 2012
GROUP BY candidate, year_
ORDER BY total_vote DESC;

-- 10. Votes per candidate per state (e.g., 1980)
SELECT candidate,
       state_,
       SUM(candidate_vote) AS total_vote
FROM presidential_election_
WHERE year_ = 1980
GROUP BY candidate, state_
ORDER BY candidate ASC;

-- 11. Vote percentage per candidate per year
SELECT 
    year_,
    candidate,
    SUM(candidate_vote) AS total_candidate_votes,
    ROUND(
        (SUM(candidate_vote) * 100.0) / 
        SUM(SUM(candidate_vote)) OVER (PARTITION BY year_), 2
    ) AS vote_percent
FROM presidential_election_
WHERE candidate IS NOT NULL AND candidate_vote > 0
GROUP BY year_, candidate
ORDER BY year_, vote_percent DESC;



