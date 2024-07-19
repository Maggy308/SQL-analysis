create database llin_analysis;
use llin_analysis;
create table llin_distribution(
Id int not null,
Number_distributed int,
location text,
country text,
year int,
by_whom text,
country_code text
);

alter table amf_distributions
change `Number distributed` Number_distributed int;
select*from amf_distributions;

-- Descriptive_statistics
-- total number of llins distributed in each country 
select  country, sum(number_distributed)
 from amf_distributions group by country;
 
 -- avg number of Llins per distribution event
 select `year`,avg (number_distributed)
 from amf_distributions group by `year`;
 
 -- earliest and latest distribution dates
 select max(year) as latest_date,min(year)as earliest_date
 from amf_distributions;
--  llin distribution per organization
select by_whom, sum(number_distributed)
 from amf_distributions group by by_whom ;
 
 -- llins distributed each year
 select year, sum(number_distributed) as distribution_per_year
 from amf_distributions group by year;
 
--  Volume Insights
-- locations vs distribution
select location, max(number_distributed) as  highest_distribution 
from amf_distributions group by location order by highest_distribution desc limit 1;

select location, min(number_distributed) as  lowest_distribution 
from amf_distributions group by location order by lowest_distribution asc limit 1 ;

-- difference in llins distributed by organizations

select by_whom, sum(number_distributed) as distributions
 from amf_distributions group by by_whom order by distributions desc;
 
 -- Identifying extremes
 select avg(number_distributed) from amf_distributions;
 
SELECT
  location,
  number_distributed,
  (number_distributed - AVG(number_distributed) OVER (PARTITION BY location)) / STDDEV(number_distributed) OVER (PARTITION BY location) AS z_score
FROM amf_distributions;
 
 
 


