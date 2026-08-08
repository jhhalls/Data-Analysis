-- ##########################################################################
-- ##                                                                      ##
-- ##   SAKILA `film` TABLE - SQL PRACTICE WORKBOOK (QUESTIONS ONLY)         ##
-- ##   MySQL | 8 topics x 5 difficulty levels x 15 questions = 600         ##
-- ##                                                                      ##
-- ##########################################################################
--
-- SCOPE
--   Every question and every answer uses ONLY the sakila.film table.
--   No JOINs. No correlated subqueries. Two Expert/Impossible answers in the
--   UNION topic use a derived table and say so explicitly, because emulating
--   INTERSECT/EXCEPT genuinely cannot be done without one - treat those as a
--   preview of your next topic.
--
-- TABLE UNDER TEST
--   film_id              SMALLINT UNSIGNED   1 .. 1000
--   title                VARCHAR(128)        uppercase, almost always 2 words
--   description          TEXT                one-sentence blurb
--   release_year         YEAR                2006 for every row
--   language_id          TINYINT UNSIGNED    1 for every row
--   original_language_id TINYINT UNSIGNED    NULL for every row  <- your NULL playground
--   rental_duration      TINYINT UNSIGNED    3, 4, 5, 6, 7
--   rental_rate          DECIMAL(4,2)        0.99, 2.99, 4.99
--   length               SMALLINT UNSIGNED   46 .. 185
--   replacement_cost     DECIMAL(5,2)        9.99 .. 29.99
--   rating               ENUM                G, PG, PG-13, R, NC-17
--   special_features     SET                 Trailers, Commentaries,
--                                            Deleted Scenes, Behind the Scenes
--   last_update          TIMESTAMP           same value for every row
--
-- REFERENCE NUMBERS FOR STOCK SAKILA (verify on your own instance)
--   COUNT(*)                = 1000
--   MIN/MAX(length)         = 46 / 185          AVG(length)  ~ 115.2720
--   SUM(length)             ~ 115272            AVG(rental_rate) ~ 2.98
--   MIN/MAX(replacement_cost) = 9.99 / 29.99    AVG(replacement_cost) ~ 19.984
--   Films per rating        ~ G 178, PG 194, PG-13 223, R 195, NC-17 210
--   Films per rate          ~ 0.99: 341, 2.99: 323, 4.99: 336
--   These appear in some answers as hard-coded literals. That is deliberate -
--   it is exactly the pain that subqueries and window functions later remove.
--
-- DIFFICULTY LADDER
--   BEGINNER      one idea, one clause, direct translation of the sentence
--   INTERMEDIATE  two ideas combined; aliases, expressions, mild logic
--   ADVANCE       computed columns, CASE, grouping on expressions, HAVING
--   EXPERT        conditional aggregation, string surgery, three-valued logic
--   IMPOSSIBLE    solvable with ONLY the eight topics, but requires a trick:
--                 median by LIMIT/OFFSET, pivots by SUM(condition), top-N-per-
--                 group by UNION ALL, branch-free logic by boolean arithmetic
--
-- TOPIC INDEX
--   1  SELECT *                    projection
--   2  AND / OR                    boolean combination, precedence, De Morgan
--   3  MIN MAX AVG SUM             aggregates
--   4  OPERATORS                   arithmetic, comparison, logical, bitwise
--   5  WHERE                       row filtering, and WHERE vs HAVING
--   6  CONCAT + WILDCARDS          string building, LIKE, REGEXP
--   7  COUNT DISTINCT ORDER BY     LIMIT, OFFSET, GROUP BY, pagination
--      LIMIT OFFSET GROUP BY
--   8  UNION                       stacking, unpivoting, report building
--
-- HOW TO USE THIS FILE
--   Run `USE sakila;` first. Work top to bottom within a topic. If an answer
--   surprises you, run the two halves of the expression separately - that is
--   where the learning is.
--
-- THIS IS THE QUESTIONS-ONLY SCRIPT
--   Write your answer in the blank space under each question. The companion
--   file sakila_film_practice_QA.sql holds the worked solutions and notes.
--   Do not open it until you have had a real attempt.
--
-- ##########################################################################

USE sakila;


-- ##########################################################################
-- TOPIC 1 : SELECT *  (projection - choosing what comes back)
-- ##########################################################################


-- ==========================================================================
-- TOPIC 1  |  BEGINNER
-- ==========================================================================

-- Q1.B01  Return every column and every row of the film catalogue.
--         [Expected: 1000 rows, 13 columns]


-- Q1.B02  Return only the title of every film.
--         [Expected: 1000 rows, 1 column]


-- Q1.B03  Return the title and the description of every film.


-- Q1.B04  Return film_id, title and length - in exactly that column order.


-- Q1.B05  Return the title, the rental_rate and the replacement_cost of every film.


-- Q1.B06  Return every column of the film table, writing the table name
--         fully qualified with its schema.


-- Q1.B07  Return just the rating column for all films.
--         [Expected: 1000 rows, lots of repetition - only 5 distinct values exist]


-- Q1.B08  Return the title, but label the output column "Film Title".


-- Q1.B09  Return the length column but label it minutes.


-- Q1.B10  Return every column, giving the film table the short alias f
--         and using that alias in the select list.


-- Q1.B11  Return the title and rating, labelled movie and certificate.


-- Q1.B12  Return only the special_features column.


-- Q1.B13  Return only the last_update column.
--         [Expected: every row is the same timestamp in stock Sakila]


-- Q1.B14  Return film_id, title, release_year and rating.


-- Q1.B15  Return the title plus a hard-coded text column called source
--         whose value is always 'Sakila'.



-- ==========================================================================
-- TOPIC 1  |  INTERMEDIATE
-- ==========================================================================

-- Q1.I01  Return description first and title second.


-- Q1.I02  Alias the table as f and return f.title, f.length, f.rating.


-- Q1.I03  Return title, length and rental_duration with the business-friendly
--         labels Movie, Runtime and LoanDays.


-- Q1.I04  Reproduce SELECT * without using the star: list all 13 columns explicitly.


-- Q1.I05  Return the title with an alias that contains a space: Film Name.


-- Q1.I06  Return the title and the runtime expressed in hours (a decimal is fine).


-- Q1.I07  Return the title and the maximum revenue one full rental period could
--         earn, i.e. rental_rate multiplied by rental_duration.


-- Q1.I08  Return the title and how much more the replacement cost is than the
--         rental rate.


-- Q1.I09  Return every column of film plus one extra computed column showing
--         the takings of three rentals.


-- Q1.I10  Alias the title column as Movie without typing the keyword AS.


-- Q1.I11  Return the length column twice in one result, once labelled minutes
--         and once labelled runtime.


-- Q1.I12  Return the title and a column named is_long that shows 1 when the film
--         runs over 120 minutes and 0 otherwise.


-- Q1.I13  Return title and original_language_id.
--         [Expected: original_language_id is NULL for all 1000 rows]


-- Q1.I14  Return every column except description.


-- Q1.I15  Return the title and the replacement_cost expressed in paise/cents
--         (i.e. multiplied by 100) as an integer-looking column named cost_minor.



-- ==========================================================================
-- TOPIC 1  |  ADVANCE
-- ==========================================================================

-- Q1.A01  Build a catalogue "spec sheet": title, rating, length, rental_rate and
--         replacement_cost, each with a clean business alias.


-- Q1.A02  For each film, how many rentals are needed before the shop recovers the
--         replacement cost? Return title and the raw ratio.


-- Q1.A03  Same as above, but round the ratio to 1 decimal place.


-- Q1.A04  Return title, whole hours and leftover minutes of the runtime as two
--         separate numeric columns.


-- Q1.A05  Return the title and the effective price per rental day, rounded to 2 dp.


-- Q1.A06  Return title and an effective_language column that falls back to
--         language_id whenever original_language_id is NULL.


-- Q1.A07  Do the same thing using COALESCE instead of IFNULL.


-- Q1.A08  Return title and a 1/0 flag named is_restricted that is 1 only for
--         films rated R.


-- Q1.A09  Return title with three flags: is_cheap (rate below 1), is_long
--         (over 120 minutes) and is_adult (rating NC-17).


-- Q1.A10  Bucket every film by runtime into 'Short' (< 60), 'Standard' (60-119)
--         and 'Long' (120+). Return title and the bucket.


-- Q1.A11  Return title and a price_tier: 'Budget' for 0.99, 'Standard' for 2.99,
--         'Premium' for anything else.


-- Q1.A12  Produce a numeric catalogue code equal to film_id multiplied by 10 plus
--         the rental_duration. Return film_id, title and the code.


-- Q1.A13  Return title, the raw special_features value and the number of
--         characters that value occupies.


-- Q1.A14  Return title and only the calendar date part of last_update.


-- Q1.A15  Return title and the shortfall: replacement_cost minus everything one
--         full rental period earns.



-- ==========================================================================
-- TOPIC 1  |  EXPERT
-- ==========================================================================

-- Q1.E01  Produce an audience label using NESTED conditions: films rated G or PG
--         are 'Family'; anything else under 90 minutes is 'Quick Adult Watch';
--         everything else is 'Adult Feature'.


-- Q1.E02  Return title and a column promo_code that is 'HALFPRICE' only for films
--         priced 4.99, and NULL for every other film.


-- Q1.E03  Use the IF() function to return 'Long' or 'Short' around a 115 minute
--         threshold.


-- Q1.E04  How many rentals are needed to fully recover the replacement cost,
--         rounded UP to a whole rental?


-- Q1.E05  Return the net position after exactly 10 rentals:
--         (rental_rate * 10) - replacement_cost, rounded to 2 dp.


-- Q1.E06  Return title and a column that is NULL whenever the rating is 'G',
--         and the rating itself otherwise - without using CASE.


-- Q1.E07  Return title and a 1/0 column showing whether original_language_id is
--         NULL, using a dedicated NULL-testing function.


-- Q1.E08  Express each film's runtime as a percentage of a 180 minute benchmark,
--         to 1 decimal place.


-- Q1.E09  Return title and a 1/0 flag showing whether the film ships with
--         'Trailers' in its special_features set.


-- Q1.E10  Return the POSITION at which 'Deleted Scenes' appears inside the
--         special_features list (0 when absent).


-- Q1.E11  Count how many special features each film has, without splitting rows.


-- Q1.E12  Count how many words are in each film's title using the same technique.
--         [Expected: nearly every Sakila title is 2 words]


-- Q1.E13  Return the FIRST word of every title.


-- Q1.E14  Return the LAST word of every title.


-- Q1.E15  Build the two-letter initials of each title, e.g. ACADEMY DINOSAUR -> AD.



-- ==========================================================================
-- TOPIC 1  |  IMPOSSIBLE
-- ==========================================================================

-- Q1.X01  Reverse the word order of every two-word title:
--         ACADEMY DINOSAUR -> DINOSAUR ACADEMY.


-- Q1.X02  Convert each title from SHOUTING CAPS to Proper Case:
--         ACADEMY DINOSAUR -> Academy Dinosaur. Handle both words.


-- Q1.X03  Extract only the text of the description that appears BEFORE the first
--         comma. If there is no comma, return the whole description.


-- Q1.X04  Count the number of words in each film's description.


-- Q1.X05  Return the numeric ASCII code of the first character of every title.
--         [Expected: 65-90, since Sakila titles are uppercase A-Z]


-- Q1.X06  Produce a fixed-width catalogue line: the title padded with dots to 30
--         characters, then the length right-aligned in a 4 character field.


-- Q1.X07  Translate each rating into a minimum viewing age (G=0, PG=8, PG-13=13,
--         R=17, NC-17=18) and return title, that age, and age + length.


-- Q1.X08  Show the rental rate as a percentage of the replacement cost, formatted
--         as a string with two decimals and a trailing % sign, e.g. '4.97%'.


-- Q1.X09  Extract the THIRD word of every description.


-- Q1.X10  Return each description with any trailing full stop removed.


-- Q1.X11  Render the runtime as an ISO-8601-style duration string, e.g. 90 -> 'PT1H30M'
--         and 46 -> 'PT0H46M'.


-- Q1.X12  Slugify each title for a URL: lowercase, spaces replaced by hyphens.


-- Q1.X13  Mask every title so only the first and last characters survive; replace
--         the middle with exactly as many asterisks as characters removed.


-- Q1.X14  Compute the digit sum of the length (e.g. 148 -> 1+4+8 = 13). Lengths are
--         2 or 3 digits, so pad to 3 first.


-- Q1.X15  Return title and a 1/0 flag showing whether the title is a palindrome
--         once spaces are ignored and case is normalised.
--         [Expected: 0 for essentially every Sakila title - the point is the expression]

-- ##########################################################################
-- TOPIC 2 : AND / OR OPERATORS  (combining conditions, NOT, precedence)
-- ##########################################################################


-- ==========================================================================
-- TOPIC 2  |  BEGINNER
-- ==========================================================================

-- Q2.B01  Films rated 'PG' that run longer than 120 minutes.


-- Q2.B02  Films rated either 'G' or 'PG'.


-- Q2.B03  Films that cost 0.99 to rent AND can be kept for 7 days.


-- Q2.B04  Films shorter than 60 minutes or longer than 180 minutes.


-- Q2.B05  Films rated 'R' with a replacement cost below 15.00.


-- Q2.B06  Films released in 2006 AND rated 'NC-17'.


-- Q2.B07  Films whose rental_duration is 3 or 4.


-- Q2.B08  Films with a rental rate of 4.99 AND a length of at least 150 minutes.


-- Q2.B09  Films that are NOT rated 'G'.


-- Q2.B10  Films that are neither 'G' nor 'PG'.


-- Q2.B11  Films with a replacement cost above 25 AND a rental rate above 2.


-- Q2.B12  Films with film_id 1, 2 or 3 written using OR.


-- Q2.B13  Films longer than 90 minutes AND shorter than 100 minutes.


-- Q2.B14  Films rated 'PG-13' AND rentable for exactly 5 days.


-- Q2.B15  Films where language_id is 1 AND original_language_id is NULL.
--         [Expected: all 1000 rows]



-- ==========================================================================
-- TOPIC 2  |  INTERMEDIATE
-- ==========================================================================

-- Q2.I01  Family-friendly bargains: rated G or PG, AND priced under 3.00.
--         Make the intent explicit with parentheses.


-- Q2.I02  Now write the same predicate WITHOUT parentheses and explain the
--         different result set you get.


-- Q2.I03  Long premium films: over 150 minutes AND priced 4.99 AND rated R or NC-17.


-- Q2.I04  Films that are cheap (0.99) OR very short (under 50 minutes), but in
--         either case must be rated G.


-- Q2.I05  Films with a rental duration of 3 or 7 AND a replacement cost between
--         10 and 20 - write the range with two AND-ed comparisons.


-- Q2.I06  Films that are NOT (long and expensive): exclude anything over 120
--         minutes that also costs 4.99.


-- Q2.I07  Rewrite Q2.I06 using De Morgan's law - no NOT keyword allowed.


-- Q2.I08  Films whose title starts with 'A' AND that are rated G or PG.


-- Q2.I09  Films that are either short-and-cheap (under 60 min and 0.99) or
--         long-and-premium (over 170 min and 4.99).


-- Q2.I10  Films where rental_duration is 4 AND (rating is G OR replacement cost
--         is under 12).


-- Q2.I11  Films that are NOT rated R and NOT rated NC-17.


-- Q2.I12  Everything that is neither very short (< 60) nor very long (> 180).


-- Q2.I13  Films with 'Trailers' in special_features AND a rating of PG-13.


-- Q2.I14  Films that are premium priced OR premium replacement value, but must
--         also be at least 100 minutes long.


-- Q2.I15  Films whose film_id is below 100 OR above 900, AND which are rated G.



-- ==========================================================================
-- TOPIC 2  |  ADVANCE
-- ==========================================================================

-- Q2.A01  Three-way OR of AND-groups: return films that satisfy ANY of
--         (G and under 60 min), (PG-13 and 4.99), (NC-17 and over 170 min).


-- Q2.A02  Films that satisfy exactly the opposite of Q2.A01.


-- Q2.A03  Value picks: price under 3.00 AND runtime over 120 AND replacement cost
--         under 20 AND rating not NC-17.


-- Q2.A04  Films where the boolean expression (length > 120) AND (rental_rate < 3)
--         is evaluated in the SELECT list as well as filtered in WHERE.


-- Q2.A05  Use XOR: films that are long (>120) or cheap (0.99) but NOT both.


-- Q2.A06  Reproduce the XOR above using only AND, OR and NOT.


-- Q2.A07  Films with two or more special features AND rated G.


-- Q2.A08  Films where the runtime in hours is above 2 AND the per-day price is
--         below 0.50 - both conditions computed, not raw columns.


-- Q2.A09  Films that break even in under 5 rentals AND are rated PG or PG-13.


-- Q2.A10  Films whose title's first word is 'AFRICAN', 'AGENT' or 'AIRPLANE',
--         AND which run over 100 minutes.


-- Q2.A11  Demonstrate NULL logic: films where original_language_id = 1 OR
--         rating = 'G'. Explain why the NULL comparison contributes nothing.


-- Q2.A12  Films where original_language_id = 1 AND rating = 'G'.
--         [Expected: 0 rows - explain why]


-- Q2.A13  Correct the previous query so that it also matches rows where
--         original_language_id is unknown.


-- Q2.A14  Films matching a nested condition three levels deep: rated R AND
--         (long OR (cheap AND high replacement cost)).


-- Q2.A15  Films that fail every one of these: not G, not under 60 min, not 0.99.



-- ==========================================================================
-- TOPIC 2  |  EXPERT
-- ==========================================================================

-- Q2.E01  Return, for the whole catalogue, how many films satisfy
--         (G or PG) AND cheap, using a boolean expression inside SUM.


-- Q2.E02  In one row, count how many films are long-AND-premium, and how many are
--         short-OR-cheap.


-- Q2.E03  Count films where XOR of (rated R) and (over 2 hours) is true.


-- Q2.E04  For each rating, how many films are both long and premium?


-- Q2.E05  Show every rating alongside how many of its films are cheap and how
--         many are expensive - two AND-free counters in one pass.


-- Q2.E06  Keep only the ratings where MORE films are long than short
--         (threshold 115 minutes).


-- Q2.E07  Films where the truth value of (length > 120) equals the truth value of
--         (replacement_cost > 20) - i.e. both true or both false.


-- Q2.E08  Films satisfying at least TWO of these three: long (>120), premium
--         (4.99), high replacement (>24). Express the count arithmetically.


-- Q2.E09  Films satisfying EXACTLY one of those three conditions.


-- Q2.E10  Films satisfying ALL THREE, written without a single AND keyword.


-- Q2.E11  For each rental_duration, report the share (0-1, 2 dp) of films that
--         are rated R or NC-17.


-- Q2.E12  Ratings where every single film is at least 46 minutes long
--         (i.e. no counter-example exists).


-- Q2.E13  Ratings where at least one film is both under 60 minutes AND premium.


-- Q2.E14  A single row summarising the whole catalogue: total films, how many are
--         family (G/PG), how many adult (R/NC-17), how many in the middle.


-- Q2.E15  Films where NOT NULL-safe equality matters: compare original_language_id
--         to NULL using the NULL-safe operator and confirm all 1000 rows match.



-- ==========================================================================
-- TOPIC 2  |  IMPOSSIBLE
-- ==========================================================================

-- Q2.X01  Produce one row per rating showing a "profile string" that lists which
--         of three properties the rating's films predominantly have: mostly long,
--         mostly premium, mostly high-replacement. Use majority (> 50%).


-- Q2.X02  Build a truth table over the catalogue: one row per combination of
--         (is_long, is_premium) with a count. No subqueries.


-- Q2.X03  Same truth table, but rendered as readable labels rather than 1/0.


-- Q2.X04  Emit a single row confirming whether the catalogue satisfies the rule
--         "every premium film is at least 60 minutes long". Return 'PASS'/'FAIL'.


-- Q2.X05  One row per rating, with a comma-separated list of every rule the
--         rating VIOLATES from: no film under 50 min, no film over 180 min,
--         no film priced 0.99.


-- Q2.X06  Count, per rating, how many of the three properties (long, premium,
--         costly) the AVERAGE film satisfies - a 0 to 3 score.


-- Q2.X07  Films where the AND of all four special features being present is true -
--         i.e. the film has Trailers, Commentaries, Deleted Scenes AND Behind the Scenes.


-- Q2.X08  Films that have EXACTLY one special feature, expressed with boolean
--         arithmetic over FIND_IN_SET rather than string length tricks.


-- Q2.X09  One row per rating showing the count of films for each feature-count
--         bucket 1..4, as four separate columns.


-- Q2.X10  Return the single rating whose films most often satisfy BOTH
--         (over 115 min) AND (replacement cost over 20). Return one row only.


-- Q2.X11  Verify De Morgan empirically: return one row proving that the count of
--         NOT(A AND B) equals the count of (NOT A) OR (NOT B), for
--         A = long, B = premium.


-- Q2.X12  For each rental_duration, output 'ALL', 'SOME' or 'NONE' describing how
--         many of its films are rated R or NC-17.


-- Q2.X13  Films where the three-way condition (rated G) OR (under 60 min AND 0.99)
--         OR (over 180 min AND 4.99) holds, ranked so that the reason for
--         inclusion is visible as a label.


-- Q2.X14  Prove that AND/OR short-circuit does NOT change results with NULLs:
--         count rows for (original_language_id = 1 OR TRUE) and for
--         (original_language_id = 1 AND TRUE) in one row.


-- Q2.X15  Return the ratings that contain NO film simultaneously violating both
--         quality rules (under 50 minutes AND priced 4.99), together with the
--         ratings that DO, labelled - all in one result via UNION.

-- ##########################################################################
-- TOPIC 3 : MIN, MAX, AVG, SUM  (aggregate functions)
-- ##########################################################################


-- ==========================================================================
-- TOPIC 3  |  BEGINNER
-- ==========================================================================

-- Q3.B01  What is the shortest film length in the catalogue?
--         [Expected: 46]


-- Q3.B02  What is the longest film length in the catalogue?
--         [Expected: 185]


-- Q3.B03  What is the average film length?
--         [Expected: ~115.2720]


-- Q3.B04  What is the total of all film lengths?
--         [Expected: ~115272]


-- Q3.B05  What is the cheapest rental rate?
--         [Expected: 0.99]


-- Q3.B06  What is the most expensive rental rate?
--         [Expected: 4.99]


-- Q3.B07  What is the average rental rate?
--         [Expected: ~2.98]


-- Q3.B08  What is the lowest replacement cost?
--         [Expected: 9.99]


-- Q3.B09  What is the highest replacement cost?
--         [Expected: 29.99]


-- Q3.B10  What is the average replacement cost?
--         [Expected: ~19.984]


-- Q3.B11  What is the shortest rental_duration offered?
--         [Expected: 3]


-- Q3.B12  What is the longest rental_duration offered?
--         [Expected: 7]


-- Q3.B13  What is the total replacement value of the entire catalogue?


-- Q3.B14  What is the alphabetically first title? (MIN works on strings too.)


-- Q3.B15  What is the alphabetically last title?



-- ==========================================================================
-- TOPIC 3  |  INTERMEDIATE
-- ==========================================================================

-- Q3.I01  Return the shortest, longest and average length in a single row.


-- Q3.I02  Return the average length rounded to 2 decimal places.


-- Q3.I03  Return the average rental rate for films rated 'G' only.


-- Q3.I04  Return the longest film length among films priced 0.99.


-- Q3.I05  Return the total runtime of all NC-17 films.


-- Q3.I06  Return the spread of lengths (max minus min) in one column.
--         [Expected: 139]


-- Q3.I07  Return the average length per rating.


-- Q3.I08  Return the min and max replacement cost per rental_duration.


-- Q3.I09  Return the total runtime per rating, longest total first.


-- Q3.I10  Return the average rental rate per rental_duration, to 2 dp.


-- Q3.I11  Return the average length expressed in hours to 2 dp.


-- Q3.I12  Return the total revenue the catalogue would generate if every film
--         were rented exactly once.


-- Q3.I13  Return the average of the computed break-even ratio
--         (replacement_cost / rental_rate), to 2 dp.


-- Q3.I14  Return min, max, avg and sum of length for films longer than 2 hours.


-- Q3.I15  Return the average replacement cost per rating, but only for ratings
--         whose average exceeds 20.



-- ==========================================================================
-- TOPIC 3  |  ADVANCE
-- ==========================================================================

-- Q3.A01  For each rating, show avg length, avg rate and avg replacement cost,
--         all rounded to 2 dp, ordered by rating.


-- Q3.A02  Show, per rating, how far its average length deviates from the overall
--         catalogue average of 115.272 minutes.


-- Q3.A03  Per rental_duration, show total revenue-per-pass and the average
--         revenue per day of loan.


-- Q3.A04  Show the difference between the maximum and the average length per
--         rating - a crude measure of skew.


-- Q3.A05  For each rental_rate tier, report the min/max/avg runtime.


-- Q3.A06  Report the average length only over films rated R or NC-17, per rating.


-- Q3.A07  Show, per rating, the total replacement value and what percentage of
--         the whole catalogue's value that represents. Catalogue total is
--         approximately 19984.00 - use it as a literal.


-- Q3.A08  Compute the average length of only the FIRST WORD group: group films by
--         the first letter of the title and show the average length per letter.


-- Q3.A09  Same grouping, but only keep initials whose average length exceeds 120.


-- Q3.A10  Report the sum of runtimes converted to whole hours per rating.


-- Q3.A11  Show min and max title alphabetically per rating.


-- Q3.A12  For each rating, show the average number of special features per film.


-- Q3.A13  Compute total projected revenue assuming each film is rented once per
--         day of its rental_duration - overall and per rating.


-- Q3.A14  Show the average length of films that DO include 'Trailers' and, in the
--         same query shape, filter to only those films.


-- Q3.A15  Per rating, the ratio of average replacement cost to average rental
--         rate, to 2 dp - how many rentals the average film needs.



-- ==========================================================================
-- TOPIC 3  |  EXPERT
-- ==========================================================================

-- Q3.E01  Conditional averages in one row: average length of G films and average
--         length of NC-17 films, side by side.


-- Q3.E02  In one row, the total replacement value of cheap films versus premium films.


-- Q3.E03  Pivot the average length by rating into five columns on one row.


-- Q3.E04  Per rating, the max length among CHEAP films only, ignoring the rest.


-- Q3.E05  Compute the population variance of length manually:
--         AVG(length*length) - AVG(length)*AVG(length).


-- Q3.E06  Compute the population standard deviation of length from that variance.


-- Q3.E07  Compute the mean absolute deviation of length around 115.272.


-- Q3.E08  Per rating, show the weighted average rental rate weighted by
--         replacement cost: SUM(rate*cost)/SUM(cost).


-- Q3.E09  Show, per rating, the gap between the mean and the midpoint of the
--         range ((min+max)/2) - positive means left-skewed.


-- Q3.E10  One row: the average length of films that have Trailers versus those
--         that do not.


-- Q3.E11  Per rental_duration, the harmonic-style metric SUM(1/rental_rate),
--         rounded to 3 dp.


-- Q3.E12  Per rating, report the average length of the SHORT half and the LONG
--         half, split at the fixed threshold of 115 minutes.


-- Q3.E13  Compute the coefficient of variation of length (stddev / mean) as a
--         percentage to 2 dp.


-- Q3.E14  Per rating, show SUM of length but counting only the minutes ABOVE 90
--         for each film (0 when shorter).


-- Q3.E15  Show total catalogue value, total value at risk (films whose
--         replacement cost exceeds 10x their rental rate), and the ratio.



-- ==========================================================================
-- TOPIC 3  |  IMPOSSIBLE
-- ==========================================================================

-- Q3.X01  Find the MEDIAN film length without any subquery or window function.
--         [Hint: 1000 rows -> average of the 500th and 501st values; do it in two
--          reads and average them yourself, or use the UNION trick below.]


-- Q3.X02  Return the 90th percentile film length (the 900th value in ascending order).


-- Q3.X03  Return the interquartile range boundaries: the 250th and 750th lengths,
--         as two labelled rows.


-- Q3.X04  Find the MODE of rental_duration - the value that occurs most often -
--         with no subquery.


-- Q3.X05  Find the rating whose films have the highest average length, returning
--         only that one row.


-- Q3.X06  Return the second-highest average length by rating.


-- Q3.X07  Build a one-row summary that contains the min, median-ish 500th value,
--         and max - by unioning three single-value reads into labelled rows.


-- Q3.X08  Compute a trimmed statistic: the SUM of all lengths excluding the
--         single shortest and single longest film, using only aggregates.


-- Q3.X09  Per rating, compute the "range utilisation": how much of the global
--         46-185 length span that rating actually covers, as a percentage.


-- Q3.X10  Produce a histogram of length in 20-minute buckets with a bar drawn
--         from asterisks, one character per 5 films.


-- Q3.X11  For each rating, output a single string of the form
--         "R: 46-185 avg 115.3 (195 films)".


-- Q3.X12  Compute the geometric mean of replacement_cost using logs.


-- Q3.X13  Compute the harmonic mean of length.


-- Q3.X14  Per rating, report the average length of the top-priced films and the
--         bottom-priced films, plus the gap between them - one row per rating.


-- Q3.X15  Return a cumulative-style report without window functions: the total
--         runtime of films at or below each 30-minute threshold, as five
--         labelled rows built by UNION.

-- ##########################################################################
-- TOPIC 4 : OPERATORS - arithmetic, comparison, logical, boolean
-- ##########################################################################


-- ==========================================================================
-- TOPIC 4  |  BEGINNER
-- ==========================================================================

-- Q4.B01  ARITHMETIC: show title and the rental rate increased by 1.00.


-- Q4.B02  ARITHMETIC: show title and the replacement cost reduced by 5.


-- Q4.B03  ARITHMETIC: show title and double the rental rate.


-- Q4.B04  ARITHMETIC: show title and the length divided by 2.


-- Q4.B05  ARITHMETIC: show title and the remainder when length is divided by 10.


-- Q4.B06  COMPARISON: films whose length equals exactly 120.


-- Q4.B07  COMPARISON: films whose rating is not 'R' using the <> operator.


-- Q4.B08  COMPARISON: films with length greater than or equal to 180.


-- Q4.B09  COMPARISON: films with replacement cost less than or equal to 10.


-- Q4.B10  RANGE: films with length between 100 and 120 inclusive.


-- Q4.B11  SET MEMBERSHIP: films rated G, PG or PG-13.


-- Q4.B12  NEGATED SET: films NOT rated R or NC-17.


-- Q4.B13  NULL TEST: films where original_language_id is NULL.
--         [Expected: 1000 rows]


-- Q4.B14  NULL TEST: films where original_language_id is NOT NULL.
--         [Expected: 0 rows]


-- Q4.B15  BOOLEAN: show title and the raw truth value of rental_rate > 2.



-- ==========================================================================
-- TOPIC 4  |  INTERMEDIATE
-- ==========================================================================

-- Q4.I01  Show title, rental_rate and the rate after a 20% increase, to 2 dp.


-- Q4.I02  Show title and the integer number of whole hours using integer division.


-- Q4.I03  Contrast / and DIV in one query for the length column.


-- Q4.I04  Show title and MOD(length, 60) using the function form of the modulo operator.


-- Q4.I05  Films whose length is an exact multiple of 30 minutes.


-- Q4.I06  Films with an EVEN film_id.


-- Q4.I07  Films with an ODD length.


-- Q4.I08  Films whose replacement cost is NOT between 15 and 25.


-- Q4.I09  Films whose rental_duration is in the set (3,5,7) AND length is between
--         90 and 150.


-- Q4.I10  Show title and a computed profit column: rental_rate * rental_duration
--         minus 10% handling, to 2 dp.


-- Q4.I11  Films where rental_rate * rental_duration exceeds 20.


-- Q4.I12  Films where the replacement cost is more than 10 times the rental rate.


-- Q4.I13  Show three boolean columns for every film: cheap, medium, premium,
--         based on rental_rate.


-- Q4.I14  Use BETWEEN on a string column: titles alphabetically between 'A' and 'C'.


-- Q4.I15  Films where length compared to rental_duration * 25 is greater -
--         a comparison between two computed values.



-- ==========================================================================
-- TOPIC 4  |  ADVANCE
-- ==========================================================================

-- Q4.A01  Show title plus the result of the arithmetic chain
--         (replacement_cost - rental_rate) / rental_duration, to 3 dp.


-- Q4.A02  Demonstrate operator precedence: compare
--         rental_rate + rental_duration * 2  against  (rental_rate + rental_duration) * 2.


-- Q4.A03  Films where integer division of length by 60 equals 2 (i.e. 2h to 2h59m).


-- Q4.A04  Show a signed comparison result using the three-way sign of
--         length - 115: -1, 0 or 1.


-- Q4.A05  Films where the NULL-safe comparison of original_language_id against
--         language_id is FALSE - proving they differ safely.


-- Q4.A06  Show what NULL arithmetic returns: title plus length + original_language_id.
--         [Expected: NULL for every row]


-- Q4.A07  Fix the previous query so a missing original_language_id counts as zero.


-- Q4.A08  Films where the rental rate rounded to the nearest whole number equals 3.


-- Q4.A09  Films where TRUNCATE(rental_rate, 0) differs from ROUND(rental_rate, 0).


-- Q4.A10  Use the unary minus and ABS together: show the negated profit gap and
--         its absolute value.


-- Q4.A11  Films where the length exceeds the average, using the literal 115.272
--         (no subquery allowed).


-- Q4.A12  Use POWER: show the square of the rental rate to 4 dp.


-- Q4.A13  Films where LEAST(length, 120) equals 120 - i.e. length is 120 or more.


-- Q4.A14  Films where GREATEST(rental_rate, 2.99) is still 2.99 - i.e. rate is
--         at or below 2.99.


-- Q4.A15  Show implicit type coercion: compare the string '120' to the numeric
--         length column and return matches.



-- ==========================================================================
-- TOPIC 4  |  EXPERT
-- ==========================================================================

-- Q4.E01  Bitwise operators: show film_id, film_id & 1 (odd test) and film_id | 1.


-- Q4.E02  Use bitwise AND to select films whose film_id has bit 4 (value 8) set.


-- Q4.E03  Bit shift: show film_id shifted left by 2 (i.e. multiplied by 4).


-- Q4.E04  Show XOR on booleans and on bits in the same row for contrast.


-- Q4.E05  Count how many films sit strictly inside one standard deviation of the
--         mean length, using the literals 115.272 and 40.426.


-- Q4.E06  Per rating, compute the average of the boolean (length > 120) as a
--         percentage to 1 dp.


-- Q4.E07  Films where the ratio comparison rental_rate / replacement_cost exceeds
--         0.10 - a relative rather than absolute operator test.


-- Q4.E08  Show integer overflow-safe arithmetic: multiply length by 1000000 and
--         cast the result to a signed integer.


-- Q4.E09  Demonstrate that division by zero yields NULL rather than an error, by
--         dividing by (rental_duration - rental_duration).


-- Q4.E10  Films where the rental rate expressed in cents is exactly divisible
--         by 99 - forcing integer arithmetic on a DECIMAL column.


-- Q4.E11  Show the interaction of BETWEEN with NULL: count rows where
--         original_language_id BETWEEN 1 AND 5.
--         [Expected: 0 - explain why it is not 1000]


-- Q4.E12  Show the interaction of IN with NULL: count rows where
--         original_language_id IN (1, NULL).


-- Q4.E13  Rank the ratings by a composite score:
--         AVG(length)/10 + AVG(rental_rate)*5 - AVG(replacement_cost)/10.


-- Q4.E14  Use the comparison operator inside HAVING with arithmetic: ratings whose
--         average length times average rate exceeds 340.


-- Q4.E15  Show the difference between = and LIKE with no wildcards, for the
--         title 'ACADEMY DINOSAUR', in one row.



-- ==========================================================================
-- TOPIC 4  |  IMPOSSIBLE
-- ==========================================================================

-- Q4.X01  Using only arithmetic operators (no CASE, no IF), produce a column that
--         is 1 for films over 120 minutes and 0 otherwise, then use it to weight
--         the rental rate.


-- Q4.X02  Compute, in a single row and using only arithmetic on booleans, the
--         percentage of the catalogue that is both long and premium, to 2 dp.


-- Q4.X03  Clamp every length into the range 60-150 using only LEAST and GREATEST.


-- Q4.X04  Without CASE or IF, produce a column that equals the rental rate for
--         G films, twice the rate for R films and zero for everything else.


-- Q4.X05  Round every length DOWN to the nearest 15 minutes using only arithmetic.


-- Q4.X06  Round every length to the NEAREST 15 minutes using only arithmetic.


-- Q4.X07  Produce a 0-100 normalised score for length using the known bounds
--         46 and 185, to 2 dp.


-- Q4.X08  Reverse-engineer the rental_rate tier index (1, 2 or 3) using only
--         arithmetic on the rate itself.


-- Q4.X09  Build a single integer key encoding rating (as 1-5), rental_duration and
--         length: rating_code * 100000 + rental_duration * 1000 + length.


-- Q4.X10  Decode the composite key from Q4.X09 back into its three parts.


-- Q4.X11  Using only boolean arithmetic, count in one row how many films match
--         0, 1, 2 or 3 of these: long, premium, costly.


-- Q4.X12  Compute a weighted desirability score and return the top 10 films:
--         length normalised 0-1, minus price normalised 0-1, plus feature count / 4.


-- Q4.X13  Detect films whose length digits are strictly increasing (e.g. 123, 148)
--         using only arithmetic - lengths are 2 or 3 digits.


-- Q4.X14  Using bitwise operators only, list the films whose film_id is a power
--         of two.


-- Q4.X15  Return one row per rating with a "balance indicator": the signed
--         difference between the count of long films and short films, expressed
--         as an arrow string.

-- ##########################################################################
-- TOPIC 5 : WHERE CLAUSE  (row filtering, and where WHERE cannot go)
-- ##########################################################################


-- ==========================================================================
-- TOPIC 5  |  BEGINNER
-- ==========================================================================

-- Q5.B01  All details of the film with film_id 100.


-- Q5.B02  All details of the film titled 'ACADEMY DINOSAUR'.


-- Q5.B03  Titles of all films rated 'NC-17'.
--         [Expected: ~210 rows]


-- Q5.B04  Titles and lengths of films longer than 150 minutes.


-- Q5.B05  Titles and rates of films that cost exactly 2.99 to rent.


-- Q5.B06  Films with a rental_duration of 7 days.


-- Q5.B07  Films with a replacement cost of exactly 29.99.


-- Q5.B08  Films whose film_id is greater than 990.


-- Q5.B09  Films released in 2006.
--         [Expected: all 1000 rows]


-- Q5.B10  Films whose language_id is 1.


-- Q5.B11  Films shorter than 50 minutes.


-- Q5.B12  Films that are not rated 'G'.


-- Q5.B13  Films with a rental rate below 1.00.


-- Q5.B14  Films whose title is exactly 'ZORRO ARK'.


-- Q5.B15  Films whose special_features field is exactly 'Trailers'.



-- ==========================================================================
-- TOPIC 5  |  INTERMEDIATE
-- ==========================================================================

-- Q5.I01  Films longer than 120 minutes that are rated PG-13.


-- Q5.I02  Films whose film_id falls in the range 200 to 210 inclusive.


-- Q5.I03  Films rated G, PG or PG-13 that cost less than 3.00.


-- Q5.I04  Films whose title contains the word 'LOVE' anywhere.


-- Q5.I05  Filter on a COMPUTED value: films whose length in hours exceeds 2.5.


-- Q5.I06  Filter on a comparison between two columns: films where the replacement
--         cost is less than five times the rental rate.


-- Q5.I07  Films whose rental_duration is NOT 3 and NOT 7.


-- Q5.I08  Films with an even film_id in the first 50 ids.


-- Q5.I09  Films where the title's first letter is 'Z'.


-- Q5.I10  Films whose title is exactly 12 characters long.


-- Q5.I11  Films updated on 15 February 2006 (filter the DATE part of a DATETIME).


-- Q5.I12  Films whose description mentions 'Documentary'.


-- Q5.I13  Films where special_features includes 'Behind the Scenes'.


-- Q5.I14  Films where the length is outside 60-180 minutes.


-- Q5.I15  Show that WHERE cannot reference a SELECT alias - then write the version
--         that works.



-- ==========================================================================
-- TOPIC 5  |  ADVANCE
-- ==========================================================================

-- Q5.A01  Films where the break-even ratio (replacement_cost / rental_rate) is
--         under 4, ordered by that ratio.


-- Q5.A02  Films that have three or more special features.


-- Q5.A03  Films whose title's first word is exactly 5 letters long.


-- Q5.A04  Films whose last word starts with the letter 'S'.


-- Q5.A05  Films where the description contains more than 15 words.


-- Q5.A06  Films where the runtime is within 5 minutes of the catalogue average
--         (115.272).


-- Q5.A07  Films priced above the average rate of 2.98 AND shorter than average.


-- Q5.A08  Films where the ratio of rental_rate to rental_duration is the highest
--         possible tier: greater than 1.50 per day.


-- Q5.A09  Films whose title contains exactly one space (two words) AND is rated R.


-- Q5.A10  Films whose title contains a digit.


-- Q5.A11  Films whose title's two words start with the SAME letter (alliteration).


-- Q5.A12  Filter groups, not rows: ratings that have more than 200 films.
--         Explain why WHERE cannot do this.


-- Q5.A13  Combine both: among films longer than 100 minutes, which ratings have
--         more than 100 such films?


-- Q5.A14  Films whose replacement cost ends in .99 - true for all rows, prove it
--         by returning the count of films where it does NOT.


-- Q5.A15  Films whose length, when divided into the rental_duration, yields more
--         than 30 minutes of content per rental day.



-- ==========================================================================
-- TOPIC 5  |  EXPERT
-- ==========================================================================

-- Q5.E01  Films matching a regular expression: title's first word is exactly
--         three letters.


-- Q5.E02  Films whose title contains a double letter (e.g. 'LL', 'SS').


-- Q5.E03  Films whose title ends in a vowel.


-- Q5.E04  Films whose description's third word is 'Epistle' or 'Documentary'.


-- Q5.E05  Films where the number of special features equals the rental_duration
--         minus 3 - a column-to-computed comparison.


-- Q5.E06  Films where at least two of these hold: length > 120, rate = 4.99,
--         replacement cost > 24.


-- Q5.E07  Films whose length is a prime-ish check: not divisible by 2, 3, 5 or 7.


-- Q5.E08  Films whose title, once spaces are stripped, is longer than 16 characters.


-- Q5.E09  Films where the first and last characters of the title are the same letter.


-- Q5.E10  Films whose rating, converted to a numeric code via FIELD, is 4 or above.


-- Q5.E11  Films where the length exceeds the average length OF ITS OWN RATING -
--         solved without subqueries by hard-coding the five per-rating averages
--         via CASE. (Averages: G 111.05, PG 112.01, PG-13 120.44, R 118.66, NC-17 113.23)


-- Q5.E12  Filter on an aggregate of a computed group key: initials (first letters)
--         whose films average over 125 minutes AND number at least 30.


-- Q5.E13  Films where special_features is exactly the full set of four features,
--         regardless of the order they are stored in.


-- Q5.E14  Films where the title sorts after 'M' but the last word sorts before 'M'.


-- Q5.E15  Films where the digit sum of film_id equals 10.



-- ==========================================================================
-- TOPIC 5  |  IMPOSSIBLE
-- ==========================================================================

-- Q5.X01  Return the films whose length is the maximum in the catalogue, without
--         a subquery.


-- Q5.X02  Return only films whose length equals the known maximum 185, and count
--         them, proving how many ties exist.


-- Q5.X03  Find films whose length is in the top 1% of the catalogue, using the
--         99th-percentile boundary read separately via OFFSET.


-- Q5.X04  Films that are the LONGEST within their rating, expressed as five
--         single-row queries unioned together.


-- Q5.X05  Films whose title is an anagram-safe match for 'DINOSAUR ACADEMY' -
--         i.e. same two words in either order.


-- Q5.X06  Films where every word of the title is at least 6 letters long
--         (two-word titles).


-- Q5.X07  Films where the title contains no vowels in its first word.


-- Q5.X08  Films whose description length in characters is in the top band: more
--         than 100 characters, and whose title is under 12 characters - a
--         "short name, long blurb" filter.


-- Q5.X09  Films that are simultaneously above the catalogue average on length,
--         below it on price, and above it on replacement cost. Use the literals
--         115.272 / 2.98 / 19.984.


-- Q5.X10  Detect duplicate titles in the catalogue - films sharing a title.
--         [Expected: 0 rows, title is unique-ish in Sakila]


-- Q5.X11  Detect gaps in the film_id sequence using only aggregates: compare the
--         count of rows to the id range.


-- Q5.X12  Films whose title's letters are in non-decreasing alphabetical order for
--         the first three characters.


-- Q5.X13  Films where the count of the letter 'A' in the title is 3 or more.


-- Q5.X14  Films that would be filtered out by a NULL-unsafe predicate but kept by
--         a NULL-safe one - demonstrate with original_language_id and count both.


-- Q5.X15  Return the single film that is closest to being "average" on all three
--         axes: minimise ABS deviations from 115.272, 2.98 and 19.984, weighted
--         equally after normalisation.

-- ##########################################################################
-- TOPIC 6 : CONCAT + WILDCARDS  (string building and LIKE pattern matching)
-- ##########################################################################


-- ==========================================================================
-- TOPIC 6  |  BEGINNER
-- ==========================================================================

-- Q6.B01  Join the title and the rating into one column separated by a space.


-- Q6.B02  Produce a column that reads "Title: ACADEMY DINOSAUR" for every film.


-- Q6.B03  Produce "ACADEMY DINOSAUR (86 min)".


-- Q6.B04  Show the title followed by the rental rate in brackets.


-- Q6.B05  WILDCARD: films whose title starts with 'A'.


-- Q6.B06  WILDCARD: films whose title ends with 'S'.


-- Q6.B07  WILDCARD: films whose title contains 'DINO' anywhere.


-- Q6.B08  WILDCARD: films whose title is exactly 5 characters long, using
--         underscores only.


-- Q6.B09  WILDCARD: films whose title's second letter is 'C'.


-- Q6.B10  WILDCARD: films whose description contains 'Drama'.


-- Q6.B11  WILDCARD: films whose special_features mentions 'Commentaries'.


-- Q6.B12  WILDCARD: films whose title does NOT start with 'A'.


-- Q6.B13  Concatenate film_id and title with a hyphen between them.


-- Q6.B14  Build "Rating: R | Length: 129".


-- Q6.B15  WILDCARD: films whose title starts with 'Z' and is followed by anything.



-- ==========================================================================
-- TOPIC 6  |  INTERMEDIATE
-- ==========================================================================

-- Q6.I01  Use CONCAT_WS to join title, rating and length with ' / ' as the separator.


-- Q6.I02  Show why CONCAT with a NULL argument destroys the whole string: build
--         title + original_language_id.
--         [Expected: NULL for all 1000 rows]


-- Q6.I03  Fix Q6.I02 with CONCAT_WS, which skips NULL arguments.


-- Q6.I04  Fix Q6.I02 instead by coalescing the NULL to the text 'none'.


-- Q6.I05  Films whose title contains 'THE' but does not start with 'THE'.


-- Q6.I06  Films whose title has at least 15 characters, expressed with underscores.


-- Q6.I07  Films whose title starts with any of A, B or C - one query.


-- Q6.I08  Films whose title's first word is exactly 'AMERICAN'.


-- Q6.I09  Films whose title contains two separate words each containing 'A'.


-- Q6.I10  Build a sentence: "ACADEMY DINOSAUR is rated PG and runs 86 minutes."


-- Q6.I11  Build a price string with a currency symbol and 2 decimals: "$0.99".


-- Q6.I12  Concatenate the title in lowercase with the rating in uppercase.


-- Q6.I13  Films whose description ends with a full stop, using a wildcard.


-- Q6.I14  Films whose special_features has exactly one entry - no comma present.


-- Q6.I15  Films whose title contains an underscore literally. Escape the wildcard.
--         [Expected: 0 rows in stock Sakila]



-- ==========================================================================
-- TOPIC 6  |  ADVANCE
-- ==========================================================================

-- Q6.A01  Build a full catalogue card:
--         "#1 ACADEMY DINOSAUR | PG | 86min | $0.99 | 6d loan".


-- Q6.A02  Build the same card but let CONCAT_WS supply the ' | ' separators.


-- Q6.A03  Films where the title's last word appears anywhere in the description.


-- Q6.A04  Films where the title's FIRST word appears in the description.


-- Q6.A05  Films whose title matches the pattern "5 letters, space, anything".


-- Q6.A06  Films whose title's second word is exactly 4 letters.


-- Q6.A07  Case sensitivity: prove LIKE is case-insensitive by default, then force
--         a case-sensitive match with BINARY.


-- Q6.A08  The case-sensitive version.


-- Q6.A09  Build a padded fixed-width report line: title left-padded to 30, rating
--         centred-ish in 6, length right-aligned in 4.


-- Q6.A10  Films where the number of characters before the first space is greater
--         than the number after it.


-- Q6.A11  Films whose special_features begins with 'Trailers' - order matters here,
--         so anchor the pattern.


-- Q6.A12  Films whose special_features ends with 'Behind the Scenes'.


-- Q6.A13  Concatenate a computed runtime string: "1h 26m".


-- Q6.A14  Build an email-style slug: lowercase title, spaces to dots, then
--         append '@sakila.example'.


-- Q6.A15  Films whose title contains a word ending in 'ING'.



-- ==========================================================================
-- TOPIC 6  |  EXPERT
-- ==========================================================================

-- Q6.E01  Group films by the first letter and build a comma-separated list of the
--         first five titles per letter.


-- Q6.E02  Per rating, produce a comma-separated list of the three longest titles.


-- Q6.E03  Build a pattern dynamically to find films whose description contains the
--         film's own rating text.


-- Q6.E04  Count, per rating, how many titles start with each of A, B and C - three
--         wildcard-driven conditional counts.


-- Q6.E05  Films whose title contains any of the three substrings 'MAN', 'GIRL',
--         'BOY' - label which one matched.


-- Q6.E06  Build a 40-character truncated description with an ellipsis when the
--         original is longer.


-- Q6.E07  Count the occurrences of the substring 'AN' in each title.


-- Q6.E08  Replace every space in the description with a pipe and report the new
--         length alongside the old.


-- Q6.E09  Build an initials-plus-id code: 'AD-001' for ACADEMY DINOSAUR film_id 1.


-- Q6.E10  Films whose initials code (as built above) starts with the letter 'A'
--         for both words.


-- Q6.E11  Use LOCATE to return the character position of the first space in each
--         title, and filter to titles where that is position 4.


-- Q6.E12  Films where 'Deleted Scenes' appears at a specific position within
--         special_features - use LOCATE and require it to be beyond character 10.


-- Q6.E13  Per rating, build a single string listing the distinct rental_rate values
--         present, comma-separated and sorted.


-- Q6.E14  Films whose title, with all vowels removed, is 8 or fewer characters.


-- Q6.E15  Films where the description's first word equals the title's first word.



-- ==========================================================================
-- TOPIC 6  |  IMPOSSIBLE
-- ==========================================================================

-- Q6.X01  Produce a full markdown table row for every film:
--         "| 1 | ACADEMY DINOSAUR | PG | 86 | $0.99 |".


-- Q6.X02  Produce a valid JSON object string per film using string building only.


-- Q6.X03  Produce a single CSV line per film with quoted text fields, escaping any
--         embedded quotes in the description.


-- Q6.X04  Build one INSERT statement per film that would recreate it in another
--         table.


-- Q6.X05  Emit a single row containing the whole catalogue's titles as one
--         comma-separated string, truncated to the first 20 titles.


-- Q6.X06  Build a per-rating "bar chart" line: rating, count, and a bar of '#'
--         one character per 10 films, all as one string.


-- Q6.X07  Convert every title to Title Case AND build a slug, in one row:
--         'Academy Dinosaur' and 'academy-dinosaur'.


-- Q6.X08  Find films whose title's first word is a substring of its last word, or
--         vice versa - using dynamically built LIKE patterns both ways.


-- Q6.X09  Build a fixed-width three-column "shelf label" including a wrapped
--         30-character first line of the description.


-- Q6.X10  Count how many films contain each of the four special features, output
--         as a single pipe-delimited string in one row.


-- Q6.X11  Films whose title, reversed, still starts with the same letter it
--         originally ended with - and show both strings.


-- Q6.X12  Build a LIKE pattern from the film's own length: find films whose
--         description contains the digit string of their length.


-- Q6.X13  Produce a "sentence case" description: first character uppercase, the
--         rest lowercase, trailing period guaranteed exactly once.


-- Q6.X14  Per rating, build a compact spec string showing min/max length and the
--         set of rates, e.g. "R 46-185 rates[0.99,2.99,4.99] n=195".


-- Q6.X15  Find films whose title matches the wildcard pattern stored in a computed
--         column: build the pattern "first letter + % + last letter" and confirm
--         the title matches it.

-- ##########################################################################
-- TOPIC 7 : COUNT, DISTINCT, ORDER BY, LIMIT, OFFSET, GROUP BY
-- ##########################################################################


-- ==========================================================================
-- TOPIC 7  |  BEGINNER
-- ==========================================================================

-- Q7.B01  How many films are in the catalogue?
--         [Expected: 1000]


-- Q7.B02  How many distinct ratings exist?
--         [Expected: 5]


-- Q7.B03  List the distinct ratings.


-- Q7.B04  List the distinct rental rates.
--         [Expected: 0.99, 2.99, 4.99]


-- Q7.B05  List the distinct rental durations.
--         [Expected: 3, 4, 5, 6, 7]


-- Q7.B06  Show all titles in alphabetical order.


-- Q7.B07  Show all titles in reverse alphabetical order.


-- Q7.B08  Show the 10 longest films.


-- Q7.B09  Show the 5 shortest films.


-- Q7.B10  Show the first 10 films by film_id.


-- Q7.B11  Skip the first 10 films and show the next 10 (page 2).


-- Q7.B12  Count how many films are rated 'R'.
--         [Expected: ~195]


-- Q7.B13  Count the films for each rating.


-- Q7.B14  Count the films for each rental_duration, ordered by duration.


-- Q7.B15  How many distinct lengths appear in the catalogue?



-- ==========================================================================
-- TOPIC 7  |  INTERMEDIATE
-- ==========================================================================

-- Q7.I01  Count films per rating, most popular rating first.


-- Q7.I02  Show the distinct combinations of rating and rental_rate that exist.


-- Q7.I03  How many distinct rating/rental_rate combinations are there? Use
--         GROUP BY and count the resulting rows yourself.
--         [Expected: 15 rows - 5 ratings x 3 rates]


-- Q7.I04  Get that same answer as a single number, using COUNT with two
--         DISTINCT expressions.
--         [Expected: 15]


-- Q7.I05  Order films by length descending, then title ascending, and show the
--         top 15.


-- Q7.I06  Show films 21 to 30 alphabetically (page 3 of 10 per page).


-- Q7.I07  Count films per rating but only include films longer than 120 minutes.


-- Q7.I08  Group by rating and rental_rate, showing the film count for each pair.


-- Q7.I09  Count films per first letter of the title.


-- Q7.I10  Show the 5 initials with the most films.


-- Q7.I11  Show COUNT(*) versus COUNT(original_language_id) to demonstrate that
--         COUNT of a column ignores NULLs.


-- Q7.I12  Order by a computed expression: films sorted by price per rental day.


-- Q7.I13  Order by an alias defined in the select list.


-- Q7.I14  Order by column position rather than name: sort by the second column.


-- Q7.I15  Count films per rating and keep only ratings with more than 200 films.



-- ==========================================================================
-- TOPIC 7  |  ADVANCE
-- ==========================================================================

-- Q7.A01  Per rating: film count, average length, min length, max length - sorted
--         by count descending.


-- Q7.A02  Group by a CASE expression: count films in Short/Standard/Long bands.


-- Q7.A03  Group by a 20-minute length bucket and count.


-- Q7.A04  Count distinct lengths per rating.


-- Q7.A05  Two-level grouping with a total row using ROLLUP.


-- Q7.A06  Paginate the longest films: page 3 with a page size of 8.


-- Q7.A07  Show the count of films per number of special features.


-- Q7.A08  Ratings ordered by their average length, showing the count too.


-- Q7.A09  Group by the last word of the title and keep groups of 3 or more films.


-- Q7.A10  Group by first word and show the words used by the most films.


-- Q7.A11  Custom sort order: list ratings from most to least restrictive using FIELD.


-- Q7.A12  Sort NULLs explicitly: order by original_language_id putting NULLs last.


-- Q7.A13  Count films per rating and per length band in one grouped result.


-- Q7.A14  Return the middle page of the alphabetical list: rows 496-505.


-- Q7.A15  Groups whose film count is between 190 and 215.



-- ==========================================================================
-- TOPIC 7  |  EXPERT
-- ==========================================================================

-- Q7.E01  Per rating, count films and show what percentage of the catalogue each
--         rating represents (total is 1000).


-- Q7.E02  Pivot: one row per rental_duration with a column per rating showing counts.


-- Q7.E03  Pivot the other way: one row per rating with a column per rental_rate.


-- Q7.E04  Count DISTINCT lengths that appear at each rental_rate, plus the total
--         films at that rate.


-- Q7.E05  Find the lengths that appear exactly once in the whole catalogue.


-- Q7.E06  Find the most common film length and how many films share it.


-- Q7.E07  Ratings where the number of distinct lengths is less than 80% of the
--         film count - i.e. lots of repeated runtimes.


-- Q7.E08  Use ROLLUP and label the total row readably.


-- Q7.E09  For each initial letter, count films and the distinct ratings present,
--         keeping only letters that use all 5 ratings.


-- Q7.E10  Show the 3rd through 7th ratings by average length - a grouped,
--         ordered, offset result.


-- Q7.E11  Group by a two-dimensional bucket: length band x price tier, with counts,
--         ordered so the largest cells come first.


-- Q7.E12  Count how many films have each exact special_features combination.


-- Q7.E13  Sort by a multi-key custom order: rating by restrictiveness descending,
--         then length descending, showing only the first film of each rating band
--         in the ordered stream.


-- Q7.E14  Ratings whose average length is above the catalogue average of 115.272
--         AND which contain at least 200 films.


-- Q7.E15  Demonstrate that DISTINCT applies to the whole row, not one column:
--         compare COUNT(DISTINCT rating) with the row count of
--         SELECT DISTINCT rating, rental_rate.



-- ==========================================================================
-- TOPIC 7  |  IMPOSSIBLE
-- ==========================================================================

-- Q7.X01  Return the 500th and 501st film lengths in ascending order so you can
--         compute the median yourself - one query, two rows.


-- Q7.X02  Produce a decile table of length: 10 rows, each the boundary value at
--         the 10th, 20th ... 100th percentile.


-- Q7.X03  Top 3 longest films per rating, without window functions.


-- Q7.X04  The single cheapest-per-day film in each rental_duration bucket.


-- Q7.X05  Build a running total by length band without window functions, using
--         one aggregate query per cumulative threshold.


-- Q7.X06  Find the length value at which the cumulative count first exceeds 500 -
--         i.e. locate the median by reading the sorted stream.


-- Q7.X07  Rank the ratings by count and show the rank as a computed integer, using
--         only ORDER BY and LIMIT (5 unioned one-row queries with literal ranks).


-- Q7.X08  Produce a complete cross-tab of rating x rental_duration counts, with row
--         and column totals, in one query.


-- Q7.X09  Find every length value that is MISSING from the 46-185 range - do it by
--         reporting how many of the 140 possible values are present.


-- Q7.X10  Return the alphabetically middle title (the 500th) and its neighbours.


-- Q7.X11  Per rating, report the count, the count of films above that rating's own
--         average length (averages hard-coded), and the resulting share.


-- Q7.X12  Detect whether any (rating, rental_rate, rental_duration) triple is
--         unique in the catalogue.


-- Q7.X13  Produce a stable, resumable pagination key: return page 50 of the
--         catalogue ordered by (length DESC, film_id ASC), 8 rows per page.


-- Q7.X14  Show that LIMIT without ORDER BY is non-deterministic by returning
--         10 rows twice in one result set via UNION ALL, and explain the risk.


-- Q7.X15  Build a complete distribution report for rental_duration: value, count,
--         percentage, and a proportional bar - sorted by frequency.

-- ##########################################################################
-- TOPIC 8 : UNION  (and UNION ALL) - stacking result sets
-- ##########################################################################
--
-- Because every question in this file is restricted to the single `film` table,
-- UNION is exercised the way it genuinely earns its keep on one table: stacking
-- differently-filtered or differently-aggregated slices of the same rows.
--
-- Golden rules to keep in mind throughout:
--   * every branch must return the SAME number of columns
--   * corresponding columns must have compatible types
--   * the FIRST branch's column names become the result's column names
--   * UNION removes duplicate rows; UNION ALL keeps them (and is faster)
--   * a single ORDER BY / LIMIT at the very end applies to the WHOLE union
-- ##########################################################################


-- ==========================================================================
-- TOPIC 8  |  BEGINNER
-- ==========================================================================

-- Q8.B01  Stack the titles of G-rated films and NC-17 rated films into one list.


-- Q8.B02  Stack the titles of very short films (< 50 min) and very long films
--         (> 180 min).


-- Q8.B03  Stack the cheapest films and the dearest films, showing title and rate.


-- Q8.B04  Combine films with rental_duration 3 and rental_duration 7.


-- Q8.B05  Union two identical queries and observe that duplicates collapse.
--         [Expected: 178 rows, not 356]


-- Q8.B06  Now use UNION ALL on the same two queries.
--         [Expected: 356 rows]


-- Q8.B07  Combine the shortest film and the longest film into a two-row result.


-- Q8.B08  The correctly parenthesised version of Q8.B07.


-- Q8.B09  Union the minimum and maximum lengths as two labelled rows.


-- Q8.B10  Union three aggregates: min, avg and max length, as labelled rows.


-- Q8.B11  Combine the titles starting with 'A' and those starting with 'Z'.


-- Q8.B12  Union the film count of G films and the film count of R films as two rows.


-- Q8.B13  Combine films priced 0.99 with films priced 2.99, ordered by title.


-- Q8.B14  Union a literal header-style row with the first three film titles.


-- Q8.B15  Combine the film_ids below 5 with those above 996.



-- ==========================================================================
-- TOPIC 8  |  INTERMEDIATE
-- ==========================================================================

-- Q8.I01  Build a two-row summary contrasting family films with adult films:
--         label, count, average length.


-- Q8.I02  A three-row price-tier report: tier label, count, total revenue per pass.


-- Q8.I03  Tag each film as SHORT or LONG using two branches rather than a CASE.


-- Q8.I04  Combine the 5 longest and 5 shortest films, labelling which end they
--         came from.


-- Q8.I05  Show that UNION deduplicates on the FULL row: union G films and cheap
--         films selecting only title, then selecting title and rating, and note
--         the different row counts.


-- Q8.I06  Same two branches with UNION ALL - the difference equals the overlap.


-- Q8.I07  Column names come from the first branch only - prove it.


-- Q8.I08  Union rows with mismatched but compatible types: a number and a string
--         in the same column position.


-- Q8.I09  Produce a per-rating count report as five explicit UNION branches, then
--         compare it mentally with the GROUP BY one-liner.


-- Q8.I10  Order the whole union by a column, not per branch.


-- Q8.I11  Apply LIMIT to the entire union result.


-- Q8.I12  Union three length bands with their counts and share of the catalogue.


-- Q8.I13  Build a two-branch "exception report": films that are cheap but long,
--         and films that are premium but short, each labelled with the anomaly.


-- Q8.I14  Union the alphabetically first and last titles per the whole catalogue.


-- Q8.I15  Combine films with all four special features and films with exactly one,
--         labelled.



-- ==========================================================================
-- TOPIC 8  |  ADVANCE
-- ==========================================================================

-- Q8.A01  Emulate INTERSECT (not available in older MySQL): find films that are
--         both G-rated and priced 0.99, using GROUP BY over a UNION ALL is not
--         allowed here - so do it with a single WHERE and explain the equivalence.


-- Q8.A02  Emulate EXCEPT: G-rated films that are NOT priced 0.99.


-- Q8.A03  Build a five-row report where each row is a rating and its longest film,
--         via UNION of five bounded queries.


-- Q8.A04  Same shape but the SHORTEST film per rating.


-- Q8.A05  Build a "totals footer" onto a grouped report using UNION ALL.


-- Q8.A06  Unpivot the catalogue: turn three numeric columns into three labelled
--         metric rows with their catalogue-wide averages.


-- Q8.A07  Unpivot per rating: for each rating emit two rows, one for avg length and
--         one for avg rate.


-- Q8.A08  Build a data-quality report as several UNION-ed checks, each returning a
--         check name and a failure count.


-- Q8.A09  A union where the branches have DIFFERENT column expressions but the same
--         shape: title + a computed reason for inclusion.


-- Q8.A10  Show the effect of UNION on ordering: without a final ORDER BY the row
--         order is not guaranteed. Then add the ORDER BY that fixes it.


-- Q8.A11  Union two aggregate branches that group differently: counts by rating and
--         counts by rental_duration, in a single tall result.


-- Q8.A12  Produce a comparison of the top 3 and bottom 3 by replacement cost.


-- Q8.A13  Union the four special-feature tallies into four rows.


-- Q8.A14  Union with a deliberate duplicate row and show UNION collapsing it while
--         UNION ALL does not - use a single film in both branches.


-- Q8.A15  Build a paginated union: rows 6-10 of the combined A-titles and B-titles list.



-- ==========================================================================
-- TOPIC 8  |  EXPERT
-- ==========================================================================

-- Q8.E01  Build a complete profile card as a tall key/value result for ONE film
--         (film_id 1), one row per attribute.


-- Q8.E02  Emulate a FULL breakdown by unioning a grouped result with subtotal rows
--         per price tier and a grand total - three levels in one result.


-- Q8.E03  Emulate INTERSECT properly with UNION ALL + GROUP BY: films that are
--         both "long" and "premium", found by stacking both sets and keeping
--         titles that appear twice.


-- Q8.E04  Emulate EXCEPT the same way: long films that are NOT premium.


-- Q8.E05  Build a pivot WITHOUT conditional aggregation, using one UNION branch per
--         rating and one column per rental_rate.


-- Q8.E06  Produce a quartile summary of length as four labelled rows read by OFFSET.


-- Q8.E07  Build a side-by-side comparison of two segments across four metrics, as
--         four rows with two value columns - requires each branch to compute both.


-- Q8.E08  Union branches with different LIMITs to build a "top and tail" sample of
--         the alphabetical list: first 3, last 3, and the count of the middle.


-- Q8.E09  Show that UNION's dedup uses the whole row: union G-films' titles with
--         G-films' titles paired to a constant, and compare the counts in one query.


-- Q8.E10  Build a per-rating "health check" where each rating contributes one row
--         with a PASS/FAIL string, using five UNION branches.


-- Q8.E11  Union a grouped result with a computed "difference from the best group"
--         row, so the report explains itself.


-- Q8.E12  Build a tall time-free "changelog": one row per distinct special_features
--         combination with its count, plus a total row, ordered with the total last.


-- Q8.E13  Union three differently-filtered top-1 queries to answer "best value,
--         longest, and cheapest per minute" in one result.


-- Q8.E14  Union with an empty branch and confirm it contributes nothing.


-- Q8.E15  Combine a GROUP BY result with a ROLLUP result via UNION and explain why
--         you would use one or the other.



-- ==========================================================================
-- TOPIC 8  |  IMPOSSIBLE
-- ==========================================================================

-- Q8.X01  Produce the top 2 films by length for EVERY rating - 10 rows - in a
--         single statement, ordered by rating then length.


-- Q8.X02  Build a full unpivot of the catalogue's four numeric columns into a tall
--         (film_id, metric, value) table - 4000 rows.


-- Q8.X03  From that tall shape, produce per-metric min/max/avg - by unioning four
--         aggregate branches instead.


-- Q8.X04  Build a complete 15-cell cross-tab of rating x rental_rate as a TALL
--         result with a grand total, using UNION ALL over grouped branches.


-- Q8.X05  Emulate a median per rating: for each rating, read its middle value by
--         OFFSET using its known film count. (Counts: G 178, PG 194, PG-13 223,
--         R 195, NC-17 210 - so offsets are 88, 96, 111, 97, 104.)


-- Q8.X06  Build a running-total report over the five rental_duration values using
--         five cumulative aggregate branches.


-- Q8.X07  Produce a full text report: a header row, one row per rating, a separator,
--         and a footer total - all as a single-column union.


-- Q8.X08  Find films that appear in ALL THREE of these sets - long, costly and
--         feature-rich - using the UNION ALL + HAVING COUNT = 3 pattern.


-- Q8.X09  Find films in EXACTLY ONE of those three sets.


-- Q8.X10  Build a symmetric-difference report: titles that are long OR premium but
--         not both, with a label saying which side they came from.


-- Q8.X11  Produce a "shape check" of the catalogue as one row per invariant, each
--         asserting an expected value and reporting the actual - a real test suite.


-- Q8.X12  Build a paginated union across TWO different sort orders: the 5 longest
--         and the 5 alphabetically-first, deduplicated so no film appears twice.


-- Q8.X13  Emulate a histogram with guaranteed rows for empty buckets, by unioning
--         one branch per bucket so zero-count buckets still appear.


-- Q8.X14  Produce a "before and after" price simulation: current revenue per pass
--         versus revenue after a 10% rise, per rating, as two labelled blocks with
--         a delta block.


-- Q8.X15  The capstone: one statement producing a complete catalogue briefing -
--         a headline block, a per-rating block, an extremes block and a footer -
--         with a synthetic sort key controlling the layout.

