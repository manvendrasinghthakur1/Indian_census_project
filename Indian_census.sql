select * from Indian_census..dataset1 

select * from Indian_census..dataset2


----------------------------------------------------------------------------------------------------------------------------------------------

--Number of rows in datasets

select count(*) from Indian_census.. dataset1

select count(*) from Indian_census.. dataset2

----------------------------------------------------------------------------------------------------------------------------------------------

-- create view 

create view Full_dataset as 

select d1.District,d1.State,d1.growth,d1.sex_ratio,d1.literacy,d2.area_km2,d2.population from Indian_census..Dataset1 d1
inner join Indian_census..Dataset2 d2 
on d1.District=d2.District and d1.State=d2.State

drop view FullDataset

select * from Full_Dataset


----------------------------------------------------------------------------------------------------------------------------------------------

--Dataset forjharkhand and bihar

select * from Full_dataset where state in ('jharkhand','bihar')



----------------------------------------------------------------------------------------------------------------------------------------------

-- Total population in india

select sum(Population) as population_of_India from Indian_census.. dataset2

----------------------------------------------------------------------------------------------------------------------------------------------

--Average growth of india

select round(avg(Growth)*100,2) as avg_growth from Indian_census..dataset1

----------------------------------------------------------------------------------------------------------------------------------------------

-- Average sex ratio  statewise
Select State, round(avg(Sex_Ratio),0) sex_ratio from Indian_census..dataset1 group by State

----------------------------------------------------------------------------------------------------------------------------------------------

--Average literacy rate State Wise

Select State, round(avg(Literacy),1) as Avg_Literacy_Rate from Indian_census..dataset1 group by State


----------------------------------------------------------------------------------------------------------------------------------------------

--Top 3 tate with highest growth

select top 3 State, round(avg(growth)*100,2) Growth from Indian_census..dataset1 group by State order by Growth desc

----------------------------------------------------------------------------------------------------------------------------------------------

--Joining both the Data set
Select  a.District, a.State, a.Growth, a.Literacy, a.Sex_Ratio,b.Area_km2, b.Population
from Indian_census..dataset1 a inner join Indian_census.. dataset2 b on a.District=b.District and a.State=b.State 

------------------------------------------ ----------------------------------------------------------------------------------------------------

--total males and total females
Select a.District,a.State, b.Population ,b.Population*((a.Sex_Ratio/1000)/1+(a.Sex_Ratio/1000)) females, b.Population*(1+(a.Sex_Ratio/1000)) males
from Indian_census.. dataset1 a inner join Indian_census.. dataset2 b
on a.District=b.District and a.State=b.State

----------------------------------------------------------------------------------------------------------------------------------------------

--total literacy rate and area of state

select a.State, round(avg(a.Literacy),2) Literacy_rate, sum(Area_km2) area from Indian_census.. dataset1 a inner join Indian_census..dataset2 b
on a.District=b.District and a.State= b.State
group by a.State


----------------------------------------------------------------------------------------------------------------------------------------------

--previous year population District wise

 select District, population , round(population/(1+growth),0) prev_yr_popu from Full_dataset

 ----------------------------------------------------------------------------------------------------------------------------------------------

 --previous population of india
 
  select sum(population) ,sum( round(population/(1+growth),0)) prev_yr_popu from Full_dataset

 ----------------------------------------------------------------------------------------------------------------------------------------------

 --top 3 district literacy wise of every state


select * from
 (select District, State,literacy, rank() over(partition by state order by literacy desc ) rnk  from Full_dataset) a
 where a.rnk in(1,2,3) order by state 



