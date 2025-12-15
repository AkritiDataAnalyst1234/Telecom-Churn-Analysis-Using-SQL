select * from telecom_churn;


/* 
By looking the data, we found that totalcharges column is string type it's datatype should be float,
so we first looked for space/missing values and converted them to 0 
and then updated the datatype from string to float
*/

select * from telecom_churn
where totalcharges=''
or totalcharges=' '
or totalcharges is null;


update telecom_churn
set totalcharges = 0
where totalcharges=' ';

alter table telecom_churn
alter column totalcharges type float
using totalcharges::float;



/*
now we are looking for null customerid so that we can delete that
*/

select * from telecom_churn
where customerid=''
or customerid=' '
or customerid is null;




---check for duplicate entries using group by 

select customerid
from telecom_churn
group by customerid
having count(*)>1;


---check for duplicate entries using CTE

with duplicate as
(select *,row_number() over(partition by customerid) rnk
from telecom_churn)

select * from duplicate where rnk>1;


---converting seniorcitizen from int to varchar 

alter table telecom_churn
alter column seniorcitizen type varchar;


update telecom_churn
set seniorcitizen=case
when seniorcitizen='0' then 'No'
else 'Yes'
end;




/* churn analysis */

select churn,count(*)
from telecom_churn
group by churn;


/* churn distribution based on gender */

select gender,churn,count(*)
from telecom_churn
group by gender,churn;



/* churn distribution based on senior citizen */

select seniorcitizen,churn,count(*)
from telecom_churn
group by seniorcitizen,churn;


/* churn percent distribution based on senior citizen */

/* 
here we are finding percent of senior citizens have churned out among all customers and  
non-senior citizens have churned out among all customers
*/

select 
	seniorcitizen,
	count(*) churn_count,
	round(100*(count(*)/sum(count(*)) over()),2) churn_percent
from telecom_churn
where churn='Yes'
group by seniorcitizen;


/* 
here we are finding percent of senior citizens have churned out among all senior citizens and 
non-senior citizens have churned out among all non senior citizens
*/

SELECT
    SeniorCitizen,
    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_count,
    COUNT(*) AS total_in_group,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE Churn = 'Yes')
        / COUNT(*), 
        2
    ) AS churn_percent
FROM telecom_churn
GROUP BY SeniorCitizen;


/* 23.61% non-Senior Citizens have churned out, out of total non-Senior Citizens and
41.68% Senior Citizens have churned out, out of total Senior Citizens
*/

/* churn distribution based on tenure */

select tenure,count(*) customer_count
from telecom_churn
where churn='Yes'
group by tenure
order by customer_count desc;

/* conclusion
many customers have churned out in the initial months and customers who used our service for long term have stayed 
that means customers are facing issue in understanding our services in inital days 
*/


/* churn on the basis of contract */

select
	contract,
	count(*) customer_count,
	count(*) filter(where churn='Yes')  churn_count
from telecom_churn
group by contract;

/* "Month-to-month" has max churn count */


/* churn on the basis of payment method */

select
	paymentMethod,
	count(*) customer_count,
	count(*) filter(where churn='Yes')  churn_count
from telecom_churn
group by paymentMethod;

/*
 "Electronic check" payment method has max churn count
*/


/* churn on the basis of InternetService */

select 
	InternetService,
	count(*) customer_count,
	count(*) filter(where churn='Yes') churn_count
from telecom_churn
group by InternetService;

---"Fiber optic" has max churn count