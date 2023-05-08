WITH 
  department_hires AS (
    SELECT 
      department_id,
      COUNT(*) AS hires_count,
      AVG(COUNT(*)) OVER () AS avg_hires_count
    FROM 
      `arboreal-stage-385814.bronze.raw_hired_employees`
    WHERE 
      EXTRACT(YEAR FROM DATE(datetime)) = 2021
    GROUP BY 
      department_id
  )

SELECT 
  dh.department_id, 
  d.department, 
  dh.hires_count
FROM 
  department_hires dh
LEFT JOIN `arboreal-stage-385814.bronze.raw_departments` d
  ON dh.department_id = d.id
WHERE 
  dh.hires_count > dh.avg_hires_count
ORDER BY 
  hires_count DESC
  