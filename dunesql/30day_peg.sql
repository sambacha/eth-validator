WITH
  st_to AS (
    SELECT
      DATE_TRUNC('day', block_time) AS day,
      SUM(token_sold_amount) AS stETH,
      SUM(token_bought_amount) AS ETH
    FROM
      (
        SELECT
          *
        FROM
          dex.trades
        WHERE
          blockchain = 'ethereum'
          AND token_sold_symbol = 'stETH'
          AND (
            token_bought_symbol = 'ETH'
            OR token_bought_symbol = 'WETH'
          )
      ) AS z
    WHERE
      (
        token_sold_amount <> 0
        OR token_bought_amount <> 0
      )
    GROUP BY
      1
  ),
  st_from AS (
    SELECT
      DATE_TRUNC('day', block_time) AS day,
      SUM(token_bought_amount) AS stETH,
      SUM(token_sold_amount) AS ETH
    FROM
      (
        SELECT
          *
        FROM
          dex.trades
        WHERE
          blockchain = 'ethereum'
          AND token_bought_symbol = 'stETH'
          AND (
            token_sold_symbol = 'ETH'
            OR token_sold_symbol = 'WETH'
          )
      ) AS z
    WHERE
      (
        token_sold_amount <> 0
        OR token_bought_amount <> 0
      )
    GROUP BY
      1
  ),
  st_peg AS (
    SELECT
      day,
      'stETH' AS token,
      1 - (stETH / CAST(eth AS DOUBLE)) AS peg
    FROM
      (
        SELECT
          *
        FROM
          st_from
        UNION ALL
        SELECT
          *
        FROM
          st_to
      ) AS z
  ),
  rck_to AS (
    SELECT
      DATE_TRUNC('day', block_time) AS day,
      SUM(token_sold_amount) AS stETH,
      SUM(token_bought_amount) AS ETH
    FROM
      (
        SELECT
          *
        FROM
          dex.trades
        WHERE
          blockchain = 'ethereum'
          AND token_sold_symbol = 'rETH'
          AND (
            token_bought_symbol = 'ETH'
            OR token_bought_symbol = 'WETH'
          )
      ) AS z
    WHERE
      (
        token_sold_amount <> 0
        OR token_bought_amount <> 0
      )
    GROUP BY
      1
  ),
  rck_from AS (
    SELECT
      DATE_TRUNC('day', block_time) AS day,
      SUM(token_bought_amount) AS stETH,
      SUM(token_sold_amount) AS ETH
    FROM
      (
        SELECT
          *
        FROM
          dex.trades
        WHERE
          blockchain = 'ethereum'
          AND token_bought_symbol = 'rETH'
          AND (
            token_sold_symbol = 'ETH'
            OR token_sold_symbol = 'WETH'
          )
      ) AS z
    WHERE
      (
        token_sold_amount <> 0
        OR token_bought_amount <> 0
      )
    GROUP BY
      1
  ),
  rck_peg AS (
    SELECT
      day,
      'rETH' AS token,
      1 - (stETH / CAST(eth AS DOUBLE)) AS peg
    FROM
      (
        SELECT
          *
        FROM
          rck_from
        UNION ALL
        SELECT
          *
        FROM
          rck_to
      ) AS z
  ),
  cr_to AS (
    SELECT
      DATE_TRUNC('day', block_time) AS day,
      SUM(token_sold_amount) AS CRETH2,
      SUM(token_bought_amount) AS ETH
    FROM
      (
        SELECT
          *
        FROM
          dex.trades
        WHERE
          blockchain = 'ethereum'
          AND token_sold_symbol = 'CRETH2'
          AND (
            token_bought_symbol = 'ETH'
            OR token_bought_symbol = 'WETH'
          )
      ) AS z
    WHERE
      (
        token_sold_amount <> 0
        OR token_bought_amount <> 0
      )
    GROUP BY
      1
  ),
  cr_from AS (
    SELECT
      DATE_TRUNC('day', block_time) AS day,
      SUM(token_bought_amount) AS CRETH2,
      SUM(token_sold_amount) AS ETH
    FROM
      (
        SELECT
          *
        FROM
          dex.trades
        WHERE
          blockchain = 'ethereum'
          AND token_bought_symbol = 'CRETH2'
          AND (
            token_sold_symbol = 'ETH'
            OR token_sold_symbol = 'WETH'
          )
      ) AS z
    WHERE
      (
        token_sold_amount <> 0
        OR token_bought_amount <> 0
      )
    GROUP BY
      1
  ),
  cr_peg AS (
    SELECT
      day,
      'CRETH2' AS token,
      1 - (CRETH2 / CAST(eth AS DOUBLE)) AS peg
    FROM
      (
        SELECT
          *
        FROM
          cr_from
        UNION ALL
        SELECT
          *
        FROM
          cr_to
      ) AS z
  ),
  r_to AS (
    SELECT
      DATE_TRUNC('day', block_time) AS day,
      SUM(token_sold_amount) AS rETH,
      SUM(token_bought_amount) AS ETH
    FROM
      (
        SELECT
          *
        FROM
          dex.trades
        WHERE
          blockchain = 'ethereum'
          AND token_sold_symbol = 'RETH'
          AND (
            token_bought_symbol = 'ETH'
            OR token_bought_symbol = 'WETH'
          )
      ) AS z
    WHERE
      (
        token_sold_amount <> 0
        OR token_bought_amount <> 0
      )
    GROUP BY
      1
  ),
  r_from AS (
    SELECT
      DATE_TRUNC('day', block_time) AS day,
      SUM(token_bought_amount) AS rETH,
      SUM(token_sold_amount) AS ETH
    FROM
      (
        SELECT
          *
        FROM
          dex.trades
        WHERE
          blockchain = 'ethereum'
          AND token_bought_symbol = 'RETH'
          AND (
            token_sold_symbol = 'ETH'
            OR token_sold_symbol = 'WETH'
          )
      ) AS z
    WHERE
      (
        token_sold_amount <> 0
        OR token_bought_amount <> 0
      )
    GROUP BY
      1
  ),
  r_peg AS (
    SELECT
      day,
      'RETH' AS token,
      1 - (rETH / CAST(eth AS DOUBLE)) AS peg
    FROM
      (
        SELECT
          *
        FROM
          r_from
        UNION ALL
        SELECT
          *
        FROM
          r_to
      ) AS z
  ),
  ankr_to AS (
    SELECT
      DATE_TRUNC('day', block_time) AS day,
      SUM(token_sold_amount) AS ankrETH,
      SUM(token_bought_amount) AS ETH
    FROM
      (
        SELECT
          *
        FROM
          dex.trades
        WHERE
          blockchain = 'ethereum'
          AND token_sold_symbol = 'ankrETH'
          AND (
            token_bought_symbol = 'ETH'
            OR token_bought_symbol = 'WETH'
          )
      ) AS z
    WHERE
      (
        token_sold_amount <> 0
        OR token_bought_amount <> 0
      )
    GROUP BY
      1
  ),
  ankr_from AS (
    SELECT
      DATE_TRUNC('day', block_time) AS day,
      SUM(token_bought_amount) AS ankrETH,
      SUM(token_sold_amount) AS ETH
    FROM
      (
        SELECT
          *
        FROM
          dex.trades
        WHERE
          blockchain = 'ethereum'
          AND token_bought_symbol = 'ankrETH'
          AND (
            token_sold_symbol = 'ETH'
            OR token_sold_symbol = 'WETH'
          )
      ) AS z
    WHERE
      (
        token_sold_amount <> 0
        OR token_bought_amount <> 0
      )
    GROUP BY
      1
  ),
  ankr_peg AS (
    SELECT
      day,
      'ankrETH' AS token,
      1 - (ankrETH / CAST(eth AS DOUBLE)) AS peg
    FROM
      (
        SELECT
          *
        FROM
          ankr_from
        UNION ALL
        SELECT
          *
        FROM
          ankr_to
      ) AS z
  ),
  v_to AS (
    SELECT
      DATE_TRUNC('day', block_time) AS day,
      SUM(token_sold_amount) AS VETH2,
      SUM(token_bought_amount) AS ETH
    FROM
      (
        SELECT
          *
        FROM
          dex.trades
        WHERE
          blockchain = 'ethereum'
          AND token_sold_symbol = 'VETH2'
          AND (
            token_bought_symbol = 'ETH'
            OR token_bought_symbol = 'WETH'
          )
      ) AS z
    WHERE
      (
        token_sold_amount <> 0
        OR token_bought_amount <> 0
      )
    GROUP BY
      1
  ),
  v_from AS (
    SELECT
      DATE_TRUNC('day', block_time) AS day,
      SUM(token_bought_amount) AS VETH2,
      SUM(token_sold_amount) AS ETH
    FROM
      (
        SELECT
          *
        FROM
          dex.trades
        WHERE
          blockchain = 'ethereum'
          AND token_bought_symbol = 'VETH2'
          AND (
            token_sold_symbol = 'ETH'
            OR token_sold_symbol = 'WETH'
          )
      ) AS z
    WHERE
      (
        token_sold_amount <> 0
        OR token_bought_amount <> 0
      )
    GROUP BY
      1
  ),
  v_peg AS (
    SELECT
      day,
      'VETH2' AS token,
      1 - (VETH2 / CAST(eth AS DOUBLE)) AS peg
    FROM
      (
        SELECT
          *
        FROM
          v_from
        UNION ALL
        SELECT
          *
        FROM
          v_to
      ) AS z
  ),
  s_to AS (
    SELECT
      DATE_TRUNC('day', block_time) AS day,
      SUM(token_sold_amount) AS SETH2,
      SUM(token_bought_amount) AS ETH
    FROM
      (
        SELECT
          *
        FROM
          dex.trades
        WHERE
          blockchain = 'ethereum'
          AND token_sold_symbol = 'SETH2'
          AND (
            token_bought_symbol = 'ETH'
            OR token_bought_symbol = 'WETH'
          )
      ) AS z
    WHERE
      (
        token_sold_amount <> 0
        OR token_bought_amount <> 0
      )
    GROUP BY
      1
  ),
  s_from AS (
    SELECT
      DATE_TRUNC('day', block_time) AS day,
      SUM(token_bought_amount) AS SETH2,
      SUM(token_sold_amount) AS ETH
    FROM
      (
        SELECT
          *
        FROM
          dex.trades
        WHERE
          blockchain = 'ethereum'
          AND token_bought_symbol = 'SETH2'
          AND (
            token_sold_symbol = 'ETH'
            OR token_sold_symbol = 'WETH'
          )
      ) AS z
    WHERE
      (
        token_sold_amount <> 0
        OR token_bought_amount <> 0
      )
    GROUP BY
      1
  ),
  s_peg AS (
    SELECT
      day,
      'SETH2' AS token,
      1 - (SETH2 / CAST(eth AS DOUBLE)) AS peg
    FROM
      (
        SELECT
          *
        FROM
          s_from
        UNION ALL
        SELECT
          *
        FROM
          s_to
      ) AS z
  )
SELECT
  *
FROM
  (
    SELECT
      'stETH' AS token,
      AVG(peg) AS peg
    FROM
      st_peg
    WHERE
      day > CURRENT_DATE - INTERVAL '7' day
    UNION ALL
    SELECT
      'CRETH2' AS token,
      AVG(peg) AS peg
    FROM
      cr_peg
    WHERE
      day > CURRENT_DATE - INTERVAL '7' day
    UNION ALL
    SELECT
      'RETH' AS token,
      AVG(peg) AS peg
    FROM
      r_peg
    WHERE
      day > CURRENT_DATE - INTERVAL '7' day
    UNION ALL
    SELECT
      'SETH2' AS token,
      AVG(peg) AS peg
    FROM
      s_peg
    WHERE
      day > CURRENT_DATE - INTERVAL '7' day
    UNION ALL
    SELECT
      'rETH' AS token,
      AVG(peg) AS peg
    FROM
      rck_peg
    WHERE
      day > CURRENT_DATE - INTERVAL '7' day
    UNION ALL
    SELECT
      'ankrETH' AS token,
      AVG(peg) AS peg
    FROM
      ankr_peg
    WHERE
      day > CURRENT_DATE - INTERVAL '7' day
  ) AS z
ORDER BY
  2 DESC