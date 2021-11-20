# web-bedrock-viz
Auto gen map from your bedrock server

Twice an hour copy your world and generate map with bedrock-viz in html format to Nginx web server

variables:
   
   GENMAP_CRON : set frequency in cron format (default 30mn : */30 * * * *)
   
   MapSource: set world folder (default /source)

You can run with
docker run -d --name mapcraft -v /path/to/myworld:/source -p 80:80 daxxi13/web-bedrock-viz

with your browser : http://<ip-of-your-docker-host>
