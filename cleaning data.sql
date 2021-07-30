select *
from Tutorial.[dbo].[DataRaw]

--Eliminate extra spaces

select 
	replace(raw,'_',' ') as 
From Tutorial..DataRaw

--eliminate '_' from Time

--With HoraRaw as (
--	select 
--		SUBSTRING(raw,1,charindex('M',raw)) as Hora
--	FROM Tutorial..dataRaw
--	)
--Select 
--Replace (hora,'_','')
--from HoraRaw

Alter table Tutorial..dataRaw
add Time0 Nvarchar 

Alter table Tutorial..dataRaw
alter column Time0 Nvarchar (250)


Update Tutorial..dataRaw
Set Time0 = SUBSTRING(raw,1,charindex('M',raw))

select *
From Tutorial..DataRaw 

--Clean extra spaces and '_' in Time

--With CTEtime as(
--select 
--	Replace(Time0,'_','') as Time1
--From Tutorial..DataRaw
--	)
--Select REPLACE(Time1,' ','')
--From CTEtime

alter table tutorial..dataraw
add Time1 NVARCHAR (15)

UpDate tutorial..DataRaw
Set Time1 = Replace(Time0,'_','')

alter table tutorial..dataraw
add Time2 NVARCHAR (10)

UpDate tutorial..DataRaw
Set Time2 = Replace(Time1,' ','')

--the same result with two replace statemets
select 
	REPLACE(REPLACE(time0,'_',''),' ','') as time3
From Tutorial..DataRaw 

--clean date

select 
SUBSTRING (raw,charindex('M',raw)+2,charindex('14',raw)) 
From tutorial..DataRaw 

--esto lo reemplazamos en una de las columnas temporales
update Tutorial ..DataRaw 
set Time0 = SUBSTRING (raw,charindex('M',raw)+2,charindex('-',raw))

--delete all the emty spaces in the left and right
update tutorial..DataRaw 
set Time0 = trim(time0)

--clean date that star with day name

select Time0,
	Substring(time0,charindex(' ',time0)+1,len(time0))
from Tutorial ..DataRaw 

update Tutorial ..DataRaw 
set Time1 = Substring(time0,charindex(' ',time0)+1,len(time0))

select replace(replace(replace(replace(Time1,'th',''),'st',''),'nd',''),'rd','')
from Tutorial ..DataRaw 

update Tutorial ..DataRaw 
set Time0 = replace(replace(replace(replace(Time1,'th',''),'st',''),'nd',''),'rd','')

select SUBSTRING(time0,1,charindex('-',time0)+3)
from Tutorial ..DataRaw 

alter table tutorial..dataRaw
add DateSplit Nvarchar (25)

update tutorial..dataRaw
set dateSplit = SUBSTRING(time0,1,charindex('-',time0)+3)

--en esta parte se agrego el año de forma artificial, no es lo correcto, ya que no podemos saber el año en todos los datos
update tutorial..dataRaw
set dateSplit = concat(DateSplit,'-2014')

--another way to split the date

select raw,
		trim(SUBSTRING(raw,CHARINDEX('M',raw)+2,len(raw)))
from Tutorial ..DataRaw 

update Tutorial ..DataRaw
set Time0 = trim(SUBSTRING(raw,CHARINDEX('M',raw)+2,len(raw)))

--eliminate kwh from the string and the additional spaces from the right

update tutorial..DataRaw
set time0 = RTRIM(replace(time0,'kwh',''))

select time0,Trim(replace(time0,'kwh',''))
From  Tutorial..DataRaw 

--try to use '_' as a character
select  Time0,
	substring(time0,1,CHARINDEX('_',time0)-1)
From Tutorial ..DataRaw

alter table tutorial..dataRaw
add DateRaw nvarchar (100)

update Tutorial ..DataRaw
set DateRaw = substring(time0,1,CHARINDEX('_',time0)-1)


Select time0,
	SUBSTRING(DateRaw,charindex(' ',dateRaw)+1,len(dateRaw))
From Tutorial ..DataRaw

Update Tutorial ..DataRaw
set time1=SUBSTRING(DateRaw,charindex(' ',dateRaw)+1,len(dateRaw))

--the last step with the date is to clean Date extra letters st, rd,th,nd

select time1, REPLACE(replace(REPLACE(REPLACE(time1,'st',''),'nd',''),'rd',''),'th','')
from Tutorial..DataRaw

Alter table tutorial..DataRaw
add Date1 Nvarchar (30)

update Tutorial ..DataRaw 
Set DAte1 = REPLACE(replace(REPLACE(REPLACE(time1,'st',''),'nd',''),'rd',''),'th','')


--get the Kwh consumed 

Select RIGHT(time0,5)
From Tutorial ..DataRaw 

alter table Tutorial..dataRaw
alter column KwH Nvarchar (10)

Update Tutorial ..DataRaw 
set kwh=RIGHT(time0,5)

select Time2,DATE1, KWH  
from Tutorial..DataRaw 

--the only thing left is to DROP the columns that are no necesary, and try to do some analysis 

--THANKS FOR WHATCHING--


select convert(int,kwh)

from tutorial..dataraw