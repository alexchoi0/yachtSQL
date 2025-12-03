-- Pgq Comprehensive - SQL:2023
-- Description: SQL test cases
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS yachts;
CREATE TABLE yachts (
    yacht_id INT64 PRIMARY KEY,
    name STRING NOT NULL,
    length_feet INT64,
    home_marina STRING
);

INSERT INTO yachts VALUES
    (1, 'Sea Breeze', 45, 'Newport Harbor'),
    (2, 'Wind Dancer', 38, 'San Diego Bay'),
    (3, 'Ocean Pearl', 52, 'Newport Harbor'),
    (4, 'Blue Horizon', 41, 'Marina del Rey'),
    (5, 'Wave Runner', 48, 'San Diego Bay');

-- Edges: Yacht Relationships (races, visits, towing assistance)
DROP TABLE IF EXISTS yacht_connections;
CREATE TABLE yacht_connections (
    from_yacht_id INT64,
    to_yacht_id INT64,
    since_year INT64,
    connection_type STRING,
    PRIMARY KEY (from_yacht_id, to_yacht_id),
    FOREIGN KEY (from_yacht_id) REFERENCES yachts(yacht_id),
    FOREIGN KEY (to_yacht_id) REFERENCES yachts(yacht_id)
);

INSERT INTO yacht_connections VALUES
    (1, 2, 2020, 'racing_partner'),
    (1, 3, 2019, 'sister_ship'),
    (2, 3, 2021, 'racing_partner'),
    (2, 4, 2022, 'assisted_tow'),
    (3, 5, 2020, 'racing_partner'),
    (4, 5, 2021, 'racing_partner');

-- ----------------------------------------------------------------------------
-- 1. PROPERTY GRAPH Definition
-- ----------------------------------------------------------------------------

-- Define a property graph over relational tables
-- Syntax: CREATE PROPERTY GRAPH graph_name
--         VERTEX TABLES (...) EDGE TABLES (...)

CREATE PROPERTY GRAPH yacht_network
    VERTEX TABLES (
        yachts AS Yacht
            KEY (yacht_id)
            PROPERTIES (yacht_id, name, length_feet, home_marina)
    )
    EDGE TABLES (
        yacht_connections AS Connected
            SOURCE KEY (from_yacht_id) REFERENCES Yacht (yacht_id)
            DESTINATION KEY (to_yacht_id) REFERENCES Yacht (yacht_id)
            PROPERTIES (since_year, connection_type)
    );


-- ----------------------------------------------------------------------------
-- 2. Basic GRAPH_TABLE Queries with MATCH Patterns
-- ----------------------------------------------------------------------------

-- Find all yachts (nodes)
-- Tag: property_graphs_pgq_comprehensive_test_select_001
SELECT yacht_id, name, length_feet
FROM GRAPH_TABLE (yacht_network
    MATCH (y IS Yacht)
    COLUMNS (y.yacht_id, y.name, y.length_feet)
);

-- Find all yacht connections (edges)
-- Tag: property_graphs_pgq_comprehensive_test_select_002
SELECT from_id, to_id, since_year
FROM GRAPH_TABLE (yacht_network
    MATCH (y1 IS Yacht) -[c IS Connected]-> (y2 IS Yacht)
    COLUMNS (y1.yacht_id AS from_id, y2.yacht_id AS to_id, c.since_year)
);

-- Find connections of Sea Breeze
-- Tag: property_graphs_pgq_comprehensive_test_select_003
SELECT connected_yacht, since_year
FROM GRAPH_TABLE (yacht_network
    MATCH (sea_breeze IS Yacht) -[c IS Connected]-> (connected IS Yacht)
    WHERE sea_breeze.name = 'Sea Breeze'
    COLUMNS (connected.name AS connected_yacht, c.since_year)
);

-- ----------------------------------------------------------------------------
-- 3. Bidirectional and Undirected Edges
-- ----------------------------------------------------------------------------

-- Find all connections (any direction)
-- Tag: property_graphs_pgq_comprehensive_test_select_004
SELECT yacht1, yacht2
FROM GRAPH_TABLE (social_network
    MATCH (p1 IS Yacht) -[f IS Friends]- (p2 IS Yacht)
    COLUMNS (p1.name AS yacht1, p2.name AS yacht2)
);

-- Find mutual friends (bidirectional check)
-- Tag: property_graphs_pgq_comprehensive_test_select_005
SELECT p1_name, p2_name
FROM GRAPH_TABLE (social_network
    MATCH (p1 IS Yacht) -[f1 IS Friends]-> (p2 IS Yacht)
        -[f2 IS Friends]-> (p1)
    COLUMNS (p1.name AS p1_name, p2.name AS p2_name)
);

-- ----------------------------------------------------------------------------
-- 4. Path Patterns and Variable-Length Paths
-- ----------------------------------------------------------------------------

-- Find friends of friends (2-hop path)
-- Tag: property_graphs_pgq_comprehensive_test_select_006
SELECT person_name, friend_of_friend_name
FROM GRAPH_TABLE (social_network
    MATCH (p IS Yacht) -[f1 IS Friends]-> (mid IS Yacht)
                        -[f2 IS Friends]-> (fof IS Yacht)
    WHERE p.yacht_id <> fof.yacht_id
    COLUMNS (p.name AS person_name, fof.name AS friend_of_friend_name)
);

-- Variable-length path: Find all reachable people within 1 to 3 hops
-- Tag: property_graphs_pgq_comprehensive_test_select_007
SELECT source_name, target_name, path_length
FROM GRAPH_TABLE (social_network
    MATCH (source IS Yacht) -[f IS Friends]->{1,3} (target IS Yacht)
    WHERE source.yacht_id < target.yacht_id
    COLUMNS (source.name AS source_name, target.name AS target_name,
             LENGTH(f) AS path_length)
);

-- Shortest path between two specific people
-- Tag: property_graphs_pgq_comprehensive_test_select_008
SELECT path_length
FROM GRAPH_TABLE (social_network
    MATCH SHORTEST (alice IS Yacht) -[path IS Friends]->+ (diana IS Yacht)
    WHERE alice.name = 'Alice' AND diana.name = 'Diana'
    COLUMNS (LENGTH(path) AS path_length)
);

-- ----------------------------------------------------------------------------
-- 5. Pattern Matching with WHERE Conditions
-- ----------------------------------------------------------------------------

-- Find close friends in the same city
-- Tag: property_graphs_pgq_comprehensive_test_select_009
SELECT p1_name, p2_name, city
FROM GRAPH_TABLE (social_network
    MATCH (p1 IS Yacht) -[f IS Friends]-> (p2 IS Yacht)
    WHERE f.strength = 'close' AND p1.city = p2.city
    COLUMNS (p1.name AS p1_name, p2.name AS p2_name, p1.city AS city)
);

-- Find friendships formed after 2020 with people over 30
-- Tag: property_graphs_pgq_comprehensive_test_select_010
SELECT younger_name, older_name, since_year
FROM GRAPH_TABLE (social_network
    MATCH (young IS Yacht) -[f IS Friends]-> (old IS Yacht)
    WHERE f.since_year > 2020 AND old.age > 30
    COLUMNS (young.name AS younger_name, old.name AS older_name, f.since_year)
);

-- ----------------------------------------------------------------------------
-- 6. Complex Pattern Matching
-- ----------------------------------------------------------------------------

-- Triangle pattern: Find three mutually connected people
-- Tag: property_graphs_pgq_comprehensive_test_select_011
SELECT p1_name, p2_name, p3_name
FROM GRAPH_TABLE (social_network
    MATCH (p1 IS Yacht) -[f1 IS Friends]-> (p2 IS Yacht)
                         -[f2 IS Friends]-> (p3 IS Yacht)
                         -[f3 IS Friends]-> (p1)
    WHERE p1.yacht_id < p2.yacht_id AND p2.yacht_id < p3.yacht_id
    COLUMNS (p1.name AS p1_name, p2.name AS p2_name, p3.name AS p3_name)
);

-- Star pattern: Find people with multiple friends
-- Tag: property_graphs_pgq_comprehensive_test_select_012
SELECT center_name, friend_count
FROM GRAPH_TABLE (social_network
    MATCH (center IS Yacht) -[f IS Friends]-> (friend IS Yacht)
    GROUP BY center.yacht_id, center.name
    HAVING COUNT(*) >= 2
    COLUMNS (center.name AS center_name, COUNT(*) AS friend_count)
);

-- Chain pattern: A -> B -> C where B is intermediate
-- Tag: property_graphs_pgq_comprehensive_test_select_013
SELECT start_name, intermediate_name, end_name
FROM GRAPH_TABLE (social_network
    MATCH (start IS Yacht) -[f1 IS Friends]-> (intermediate IS Yacht)
                            -[f2 IS Friends]-> (end IS Yacht)
    WHERE start.yacht_id <> end.yacht_id
    COLUMNS (start.name AS start_name,
             intermediate.name AS intermediate_name,
             end.name AS end_name)
);

-- ----------------------------------------------------------------------------
-- 7. Aggregations in Graph Queries
-- ----------------------------------------------------------------------------

-- Count friends per person
-- Tag: property_graphs_pgq_comprehensive_test_select_014
SELECT person_name, friend_count
FROM GRAPH_TABLE (social_network
    MATCH (p IS Yacht) -[f IS Friends]-> (friend IS Yacht)
    GROUP BY p.yacht_id, p.name
    COLUMNS (p.name AS person_name, COUNT(*) AS friend_count)
)
ORDER BY friend_count DESC;

-- Average age of friends
-- Tag: property_graphs_pgq_comprehensive_test_select_015
SELECT person_name, avg_friend_age
FROM GRAPH_TABLE (social_network
    MATCH (p IS Yacht) -[f IS Friends]-> (friend IS Yacht)
    GROUP BY p.yacht_id, p.name
    COLUMNS (p.name AS person_name, AVG(friend.age) AS avg_friend_age)
);

-- Find the oldest friendship per person
-- Tag: property_graphs_pgq_comprehensive_test_select_016
SELECT person_name, oldest_friendship_year
FROM GRAPH_TABLE (social_network
    MATCH (p IS Yacht) -[f IS Friends]-> (friend IS Yacht)
    GROUP BY p.yacht_id, p.name
    COLUMNS (p.name AS person_name, MIN(f.since_year) AS oldest_friendship_year)
);

-- ----------------------------------------------------------------------------
-- 8. Optional Patterns (LEFT/RIGHT/FULL)
-- ----------------------------------------------------------------------------

-- Find people and their friends (including those with no friends)
-- Tag: property_graphs_pgq_comprehensive_test_select_017
SELECT person_name, friend_name
FROM GRAPH_TABLE (social_network
    MATCH (p IS Yacht) OPTIONAL -[f IS Friends]-> (friend IS Yacht)
    COLUMNS (p.name AS person_name, friend.name AS friend_name)
);

-- ----------------------------------------------------------------------------
-- 9. Path Information and Metadata
-- ----------------------------------------------------------------------------

-- Get full path information including all intermediate nodes
-- Tag: property_graphs_pgq_comprehensive_test_select_018
SELECT source_name, path_nodes, target_name
FROM GRAPH_TABLE (social_network
    MATCH (source IS Yacht) -[path IS Friends]->{2,2} (target IS Yacht)
    COLUMNS (source.name AS source_name,
             ARRAY_AGG(path.*.name) AS path_nodes,
             target.name AS target_name)
);

-- Find paths with accumulated edge properties
-- Tag: property_graphs_pgq_comprehensive_test_select_019
SELECT p1_name, p2_name, total_years
FROM GRAPH_TABLE (social_network
    MATCH (p1 IS Yacht) -[path IS Friends]->+ (p2 IS Yacht)
    WHERE LENGTH(path) <= 2
    COLUMNS (p1.name AS p1_name,
             p2.name AS p2_name,
             SUM(path.*.since_year) AS total_years)
);

-- ----------------------------------------------------------------------------
-- 10. Graph Operations with Regular SQL
-- ----------------------------------------------------------------------------

-- Combine graph query with regular WHERE clause
-- Tag: property_graphs_pgq_comprehensive_test_select_020
SELECT name, age, friend_count
FROM (
-- Tag: property_graphs_pgq_comprehensive_test_select_021
    SELECT p.yacht_id, p.name, p.age, COUNT(f.to_yacht_id) AS friend_count
    FROM GRAPH_TABLE (social_network
        MATCH (p IS Yacht) OPTIONAL -[f IS Friends]-> (friend IS Yacht)
        COLUMNS (p.yacht_id, p.name, p.age, f.to_yacht_id)
    )
    GROUP BY p.yacht_id, p.name, p.age
)
WHERE age > 25
ORDER BY friend_count DESC;

-- Join graph query results with external table
DROP TABLE IF EXISTS person_scores;
CREATE TABLE person_scores (
    yacht_id INT64 PRIMARY KEY,
    score FLOAT64
);

INSERT INTO person_scores VALUES (1, 95.5), (2, 87.3), (3, 92.1), (4, 88.9), (5, 91.2);

-- Tag: property_graphs_pgq_comprehensive_test_select_022
SELECT g.person_name, g.friend_count, s.score
FROM (
-- Tag: property_graphs_pgq_comprehensive_test_select_023
    SELECT p.yacht_id, p.name AS person_name, COUNT(*) AS friend_count
    FROM GRAPH_TABLE (social_network
        MATCH (p IS Yacht) -[f IS Friends]-> (friend IS Yacht)
        COLUMNS (p.yacht_id, p.name)
    )
    GROUP BY p.yacht_id, p.name
) g
JOIN person_scores s ON g.yacht_id = s.yacht_id
WHERE s.score > 90;

-- ----------------------------------------------------------------------------
-- 11. Advanced Patterns: Negative Patterns
-- ----------------------------------------------------------------------------

-- Find people who are NOT friends with someone in the same city
-- Tag: property_graphs_pgq_comprehensive_test_select_024
SELECT p1_name, p2_name, city
FROM GRAPH_TABLE (social_network
    MATCH (p1 IS Yacht), (p2 IS Yacht)
    WHERE p1.city = p2.city
      AND p1.yacht_id < p2.yacht_id
      AND NOT EXISTS (
          MATCH (p1) -[f IS Friends]- (p2)
      )
    COLUMNS (p1.name AS p1_name, p2.name AS p2_name, p1.city AS city)
);

-- ----------------------------------------------------------------------------
-- 12. Multiple Edge Types (if extended schema)
-- ----------------------------------------------------------------------------

-- Extended schema with multiple relationship types
DROP TABLE IF EXISTS work_relationships;
CREATE TABLE work_relationships (
    from_yacht_id INT64,
    to_yacht_id INT64,
    marina STRING,
    role STRING,
    PRIMARY KEY (from_yacht_id, to_yacht_id)
);

INSERT INTO work_relationships VALUES
    (1, 2, 'TechCorp', 'colleagues'),
    (3, 4, 'StartupXYZ', 'manager-subordinate');

-- Define extended property graph with multiple edge types
CREATE PROPERTY GRAPH extended_network
    VERTEX TABLES (
        yachts AS Yacht KEY (yacht_id) PROPERTIES ALL COLUMNS
    )
    EDGE TABLES (
        friendships AS Friends
            SOURCE KEY (from_yacht_id) REFERENCES Yacht
            DESTINATION KEY (to_yacht_id) REFERENCES Yacht
            PROPERTIES ALL COLUMNS,
        work_relationships AS WorksWith
            SOURCE KEY (from_yacht_id) REFERENCES Yacht
            DESTINATION KEY (to_yacht_id) REFERENCES Yacht
            PROPERTIES ALL COLUMNS
    );

-- Find people who are both friends AND work together
-- Tag: property_graphs_pgq_comprehensive_test_select_025
SELECT p1_name, p2_name, marina
FROM GRAPH_TABLE (extended_network
    MATCH (p1 IS Yacht) -[f IS Friends]-> (p2 IS Yacht),
          (p1) -[w IS WorksWith]-> (p2)
    COLUMNS (p1.name AS p1_name, p2.name AS p2_name, w.marina)
);

-- Find different relationship types between same people
-- Tag: property_graphs_pgq_comprehensive_test_select_026
SELECT p1_name, p2_name, rel_type
FROM GRAPH_TABLE (extended_network
    MATCH (p1 IS Yacht) -[r IS Friends | WorksWith]-> (p2 IS Yacht)
    COLUMNS (p1.name AS p1_name,
             p2.name AS p2_name,
             CASE
                 WHEN r IS Friends THEN 'friend'
                 WHEN r IS WorksWith THEN 'colleague'
             END AS rel_type)
);

-- ----------------------------------------------------------------------------
-- 13. Graph Analytics Queries
-- ----------------------------------------------------------------------------

-- Degree centrality: Find most connected people
-- Tag: property_graphs_pgq_comprehensive_test_select_027
SELECT person_name, in_degree, out_degree, total_degree
FROM GRAPH_TABLE (social_network
    MATCH (p IS Yacht)
    COLUMNS (
        p.name AS person_name,
        COUNT(INCOMING Friends) AS in_degree,
        COUNT(OUTGOING Friends) AS out_degree,
        COUNT(INCOMING Friends) + COUNT(OUTGOING Friends) AS total_degree
    )
)
ORDER BY total_degree DESC;

-- Find bridges: edges whose removal disconnects the graph
-- (Simplified heuristic: edges where endpoints have no common neighbors)
-- Tag: property_graphs_pgq_comprehensive_test_select_028
SELECT p1_name, p2_name
FROM GRAPH_TABLE (social_network
    MATCH (p1 IS Yacht) -[f IS Friends]-> (p2 IS Yacht)
    WHERE NOT EXISTS (
        MATCH (p1) -[f1 IS Friends]-> (common IS Yacht) <-[f2 IS Friends]- (p2)
        WHERE common.yacht_id <> p1.yacht_id AND common.yacht_id <> p2.yacht_id
    )
    COLUMNS (p1.name AS p1_name, p2.name AS p2_name)
);

-- ----------------------------------------------------------------------------
-- 14. Temporal Graph Queries
-- ----------------------------------------------------------------------------

-- Find friendships that formed in a specific period
-- Tag: property_graphs_pgq_comprehensive_test_select_029
SELECT p1_name, p2_name, since_year
FROM GRAPH_TABLE (social_network
    MATCH (p1 IS Yacht) -[f IS Friends]-> (p2 IS Yacht)
    WHERE f.since_year BETWEEN 2020 AND 2021
    COLUMNS (p1.name AS p1_name, p2.name AS p2_name, f.since_year)
)
ORDER BY f.since_year;

-- Find the evolution of friendship network (cumulative over time)
-- Tag: property_graphs_pgq_comprehensive_test_select_030
SELECT year, COUNT(*) AS cumulative_friendships
FROM GRAPH_TABLE (social_network
    MATCH (p1 IS Yacht) -[f IS Friends]-> (p2 IS Yacht)
    COLUMNS (f.since_year AS year)
)
GROUP BY year
ORDER BY year;

-- ----------------------------------------------------------------------------
-- 15. Edge Cases and NULL Handling
-- ----------------------------------------------------------------------------

-- Handle nodes with NULL properties
INSERT INTO yachts VALUES (6, 'Frank', NULL, NULL);

-- Tag: property_graphs_pgq_comprehensive_test_select_031
SELECT name, age, city
FROM GRAPH_TABLE (social_network
    MATCH (p IS Yacht)
    WHERE p.age IS NULL OR p.city IS NULL
    COLUMNS (p.name AS name, p.age AS age, p.city AS city)
);

-- Empty graph query result
-- Tag: property_graphs_pgq_comprehensive_test_select_032
SELECT person_name
FROM GRAPH_TABLE (social_network
    MATCH (p IS Yacht)
    WHERE p.age > 100
    COLUMNS (p.name AS person_name)
);

-- ----------------------------------------------------------------------------
-- 16. DROP Property Graph
-- ----------------------------------------------------------------------------

DROP PROPERTY GRAPH social_network;

DROP PROPERTY GRAPH extended_network;

-- End of Property Graph Queries Tests
