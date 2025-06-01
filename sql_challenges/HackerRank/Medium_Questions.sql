--THE PAD (median)-----------------------------------------------------------------

SELECT name || '(' || UPPER(SUBSTR(occupation, 1, 1)) || ')'
FROM occupations
ORDER BY name;

SELECT 'There are a total of ' || COUNT(*) || ' ' || LOWER(occupation) || 's.'
FROM occupations
GROUP By occupation
ORDER BY COUNT(*);
