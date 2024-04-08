SELECT a.name as Winner,
    b.name as Loser,
    (a.attack - b.defense) -(b.attack - a.defense) AS Match_Result
FROM pk_mon AS a,
    pk_mon AS b
WHERE a.attack - b.defense > b.attack - a.defense;
/* Buscar query de quais tipos que existem, mas não tem pokemons cadastrados
 e pesquisar quais os tipos que têm cadastrados */
SELECT *
FROM pk_types
WHERE type IN (
        SELECT DISTINCT type
        FROM pk_mon
        UNION
        SELECT DISTINCT type_scnd
        FROM pk_mon
        WHERE pk_types.type = pk_mon.type
    );
SELECT *
FROM pk_types
WHERE NOT EXISTS (
        SELECT *
        FROM pk_mon
        WHERE pk_types.type = pk_mon.type
    );
SELECT pk_types.type
FROM pk_types
    LEFT JOIN pk_mon ON pk_types.type = pk_mon.type
WHERE pk_mon.type IS NULL;
SELECT DISTINCT pk_types.type
FROM pk_types
    INNER JOIN pk_mon ON pk_types.type = pk_mon.type;
/* Buscar batalhas e maiores vencedores e quantidade de batalhas */
SELECT winner as pokemon,
    COUNT(winner) as wins
FROM (
        SELECT a.name as winner,
            b.name as loser
        FROM pk_mon AS a,
            pk_mon AS b
        WHERE a.attack - b.defense > b.attack - a.defense
    ) AS matches
GROUP BY winner
ORDER BY wins DESC;
SELECT winner as pokemon,
    COUNT(winner) as wins,
    COUNT(loser) as losses
FROM (
        SELECT a.name as winner,
            b.name as loser
        FROM pk_mon AS a,
            pk_mon AS b
        WHERE a.attack - b.defense > b.attack - a.defense
    ) AS matches
GROUP BY winner
ORDER BY losses DESC;