With purch_an as (select 
    PAM.*, ZM."User Desc" 
from 
    ZINT_PR.UI_ALL.VW_RPT_PURCHASE_ANOMALIES_MODEL as PAM
left join 
    (SELECT "User ID", "User Desc" 
        FROM "ZINT_MASTER"."UI_SEC"."AD Account") 
    AS ZM on ZM."User ID" = PAM."Requisitioner Master"
    where "Purchase Doc Date" >= DATEADD(DAY, -450, GETDATE())
    LIMIT 1000)

select * from purch_an
where "User Desc" is not null;