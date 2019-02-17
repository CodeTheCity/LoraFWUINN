# Saturday, 16.2.19

* Progress so far: We got the Lora32u4 board to send a 'Hello, world!' message to the Things Network Gateway via LoRaWan
* We did this by using the lmic library
* Issues we encountered:
  * Library code was too large to be stored on board
    * Fix: Remove some of the library functionality
  * The Pin mapping was incorrect by library default
    * Changed it to some magic mapping Michael found (https://primalcortex.wordpress.com/2017/11/10/using-the-bsfrance-lora32u4-board-to-connect-to-the-things-network-lorawan/)
* Left for tomorrow:
  * Interface with the existing chip in the kit
  * Kit should send message to LoRa chip
  * LoRa chip broadcasts message and confirms broadcasting message
* Max message length is 51 bytes

# Sunday, 17.2.19
* SoftwareSerial does not work reliably at high baud rates
* digitalWrite is only able to send HIGH and LOW messages (representing voltage levels), can e.g. be used for interrupts
* To-Do List for today:
  * Be able to receive ANY message from ANY device on the Lora32u4 via a serial pin
  * esp8266 must be able to send ANY message from a serial pin
  * Lora32u4 should be able to receive ANY message from esp8266
  * esp8266 must be able to send its air sensor payload via a serial pin
  * Lora32u4 must be able to split esp8266 air sensor payload into 51-byte sized packets
  * Lora32u4 must define a protocol for sending packets via Lora
  * Lora32u4 must be able to send messages via LoRa when fed with data from esp8266
* esp8266 payload:
  * Always sends PMS (Particle Measure System) data, may send additional data (set via config variables) which consist of temperature, humidity, pressure, GPS coordinates, 
  * First sends PMS data to Luftdaten (I think - this is stored in result_PPD OR result_SDS) THEN sends additional data (see above)
  * Aggregates data in variable data which is sent in one message (contrary to Luftdaten service) to Madavi, opensensemap, custom influx db, csv, etc.
  * IMPORTANT: send_lora function is already implemented - triggered via send2lora variable (sends the aggregated data pack) --> modify this
  * send_lora function - line 1789 to 1863