1. Create model class -> structure of data
2. Create API service class
   Key concepts:

   async / await → API calls are time-consuming

   statusCode == 200 → success

   jsonDecode() → JSON string → Map
   
3. Use API in UI (Stateful widget)



---------------------------------------------------------------



Important concepts you must understand

1\. Why StatefulWidget?



Because API data changes UI after loading.



2\. Why Future?



API calls take time. Flutter must wait.



3\. Why async / await?



To pause execution until API response arrives.



4\. Why setState()?



To tell Flutter:



“Data changed, rebuild UI”

