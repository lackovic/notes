-- Backup copy of the query to generate dbdiagram.io DDL, copied from:
-- https://github.com/matthewoldham/dbdiagram.io-ddl-queries/blob/master/sql/postgresql.sql

WITH tableKeys AS (
   SELECT t.constraint_schema,
          t.table_name,
          c.column_name,
          'PK' AS column_key
     FROM information_schema.table_constraints t
     JOIN information_schema.constraint_column_usage c 
       ON c.constraint_schema = t.constraint_schema
      AND c.table_name = t.table_name
      AND c.constraint_name = t.constraint_name
    WHERE t.constraint_type = 'PRIMARY KEY'
),
tableColumns AS (
   SELECT t.table_schema,
          t.table_name,
          c.column_name,
          COALESCE(tk.column_key::TEXT,'') AS column_pk,
          CASE
             WHEN data_type IN ('USER-DEFINED',
                                'timestamp without time zone',
                                'timestamp with time zone',
                                 'character varying') THEN udt_name
             ELSE data_type
          END AS column_type
     FROM information_schema.columns c
     JOIN information_schema.tables t
       ON c.table_schema = t.table_schema
      AND c.table_name = t.table_name
     LEFT JOIN tableKeys tk
       ON tk.constraint_schema = t.table_schema
      AND tk.table_name = t.table_name
      AND tk.column_name = c.column_name
    WHERE t.table_type = 'BASE TABLE'
    ORDER BY t.table_name, c.ordinal_position
),
tableDefs AS(
   SELECT table_schema,
          CONCAT_WS(' ','Table',table_name,'{',CHR(10)) AS table_prefix,
          ARRAY_TO_STRING(ARRAY_AGG(CONCAT_WS(' ','  ',QUOTE_IDENT(column_name),column_type,column_pk)),CHR(10)) AS column_list,
          CONCAT(CHR(10),'}',CHR(10)) AS table_suffix
     FROM tableColumns
    GROUP BY 1,2,4
    ORDER BY 2
),                      
relDefs AS (
   SELECT tc.table_schema,
          CONCAT('Ref: ',tc.table_name,'.',kcu.column_name,' > ',ccu.table_name,'.',ccu.column_name,CHR(10)) AS relationships
     FROM information_schema.table_constraints AS tc 
     JOIN information_schema.key_column_usage AS kcu
       ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema = kcu.table_schema
     JOIN information_schema.constraint_column_usage AS ccu
       ON ccu.constraint_name = tc.constraint_name
      AND ccu.table_schema = tc.table_schema
    WHERE tc.constraint_type = 'FOREIGN KEY' 
    ORDER BY tc.table_name,
             kcu.column_name,
             ccu.table_name,
             ccu.column_name
)
SELECT CONCAT(table_prefix,column_list,table_suffix) AS ddl
  FROM tableDefs
 WHERE table_schema = 'public'
UNION ALL
SELECT relationships AS ddl
  FROM relDefs
 WHERE table_schema = 'public'