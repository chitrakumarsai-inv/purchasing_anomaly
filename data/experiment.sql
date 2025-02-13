With purch_an as (select 
    PAM.*, ZM."User Desc" 
from 
    ZINT_PR.UI_ALL.VW_RPT_PURCHASE_ANOMALIES_MODEL as PAM
left join 
    (SELECT "User ID", "User Desc", "User Manager Email"
        FROM "ZINT_MASTER"."UI_SEC"."AD Account") 
    AS ZM on ZM."User ID" = PAM."Requisitioner Master"
    where "Purchase Doc Date" >= DATEADD(DAY, -450, GETDATE())
    LIMIT 1000)

-- SELECT * FROM "ZINT_MASTER"."UI_SEC"."AD Account" LIMIT 10;

-- select * from purch_an;
