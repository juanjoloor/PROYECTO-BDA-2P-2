-- drill down

select  dd.englishmonthname, dd.englishdaynameofweek, sum(f.orderquantity) cantidad_total
from factinternetsales f
join dimdate dd ON dd.datekey = f.orderdatekey
group by (dd.englishmonthname, dd.englishdaynameofweek)
order by dd.englishmonthname DESC;

--roll up

select CAST(dd.DAYNUMBEROFWEEK as varchar) dayweek , CAST(dd.DAYNUMBEROFMONTH as varchar) daymonth  , CAST(dd.DAYNUMBEROFYEAR as varchar) dayyear ,  sum(f.orderquantity) cantidad_total
from factinternetsales f
join dimdate dd on f.orderdatekey = dd.datekey
join dimproduct dp on f.productkey = dp.productkey
join dimproductcategory dpc on dp.productcategorykey = dpc.productcategorykey
join DIMPRODUCTSUBCATEGORY dpsc on dp.productsubcategorykey =  dpsc.productsubcategorykey
group by rollup(dd.DAYNUMBEROFWEEK , dd.DAYNUMBEROFMONTH ,dd.DAYNUMBEROFYEAR )

-- dice

select  prod.size ,sum(f.orderquantity) cantidad_total
from factinternetsales f
join dimproduct prod on f.productkey = prod.productkey
join dimproductcategory prodc on prod.productcategorykey = prodc.productcategorykey
where prodc.englishproductcategoryname='Clothing'
group by (prod.size)
