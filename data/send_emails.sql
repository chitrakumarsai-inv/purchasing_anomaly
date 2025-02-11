CREATE OR REPLACE PROCEDURE send_email_with_table_attachment()
RETURNS STRING
LANGUAGE JAVASCRIPT
AS 
$$
try {
    // Step 1: Export table data to a staged CSV file
    var export_query = `COPY INTO @STAGE_PURCHASING_ANOMALY/pruchasing_weekly_report.csv
                        FROM DS_D_WORKSPACE.PURCHASING_ANOMALY.PURCHASES_ANOMALY_RESULTS_LAST_WEEK
                        FILE_FORMAT = (TYPE = CSV, FIELD_OPTIONALLY_ENCLOSED_BY = '"')
                        HEADER = TRUE;`;

    snowflake.execute({sqlText: export_query});

    // Step 2: Send an email with the CSV attachment
    var email_query = `CALL SYSTEM$SEND_EMAIL(
                           'your_email_integration',
                           'recipient@example.com',
                           'Snowflake Table Export',
                           'Attached is the exported table data.',
                           '@your_stage/your_table_export.csv'
                       );`;

    snowflake.execute({sqlText: email_query});

    return "Email Sent Successfully with Table Attachment";
} 
catch (err) {
    return "Error: " + err.message;
}
$$;
