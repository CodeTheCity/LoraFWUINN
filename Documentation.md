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