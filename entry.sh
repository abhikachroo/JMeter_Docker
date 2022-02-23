#! /bin/sh
echo "Running JMeter Tests"
sh jmeter -Jthreads=1 -Jrampup=10 -Jhost=api-test.perfect-id.com -Jduration=600 -n -t /opt/tests/News.jmx -l /opt/results/news_output_$(date +'%m%d%Y').jtl -e -o /opt/results/News_HTML_$(date +'%m%d%Y')

echo "Uploading reports"
/s4_venv/bin/s4cmd \
    --access-key=NCFH3PIAADMLZA9ABUXN \
    --secret-key=aoRRhDMBRbrocpCuWts2Vj8j0KuMn3NdlAXdBPTk \
    --endpoint-url=https://obs.eu-de.otc.t-systems.com \
    put -r -f /opt/results s3://api-testing/
echo "Finished"
