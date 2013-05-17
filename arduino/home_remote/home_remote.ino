#include <SPI.h>         // needed for Arduino versions later than 0018
#include <Ethernet.h>
#include <EthernetUdp.h>         // UDP library from: bjoern@cs.stanford.edu 12/30/2008
#include <IRremote.h>

// Enter a MAC address and IP address for your controller below.
// The IP address will be dependent on your local network:
byte mac[] = {  
  0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress ip(192, 168, 1, 177);

unsigned int localPort = 8888;      // local port to listen on

// buffers for receiving and sending data
char packetBuffer[UDP_TX_PACKET_MAX_SIZE]; //buffer to hold incoming packet,
char  ReplyBuffer[] = "acknowledged";       // a string to send back

// An EthernetUDP instance to let us send and receive packets over UDP
EthernetUDP Udp;

// Infrared sender
IRsend irsend;

void setup() {
  // start the Ethernet and UDP:
  Ethernet.begin(mac,ip);
  Udp.begin(localPort);
  
  pinMode(8, OUTPUT);

  Serial.begin(9600);
}

void loop() {
  // if there's data available, read a packet
  int packetSize = Udp.parsePacket();
  if(packetSize)
  {
    Serial.print("Received packet of size ");
    Serial.println(packetSize);
    Serial.print("From ");
    IPAddress remote = Udp.remoteIP();
    for (int i =0; i < 4; i++)
    {
      Serial.print(remote[i], DEC);
      if (i < 3)
      {
        Serial.print(".");
      }
    }
    Serial.print(", port ");
    Serial.println(Udp.remotePort());

    // read the packet into packetBufffer
    Udp.read(packetBuffer,UDP_TX_PACKET_MAX_SIZE);
    //Serial.println("Contents:");
    //Serial.println(packetBuffer);
    
    String message = packetBuffer;
    Serial.println(message);
    
    int protocolEndPos = message.indexOf(";");
    if(protocolEndPos > -1) {
      String protocol = message.substring(0, protocolEndPos);
      int numBitsEndPos = message.indexOf(";", protocolEndPos + 1);
      if(numBitsEndPos > -1) {
        String numBits = message.substring(protocolEndPos + 1, numBitsEndPos);
        String data = message.substring(numBitsEndPos + 1);
        
        int iNumBits = numBits.toInt();
        long lData = data.toInt();
        
        Serial.println(protocol);
        Serial.println(numBits);
        Serial.println(iNumBits);
        Serial.println(data);
        Serial.println(lData);
        
        if(numBits > 0 && lData > 0) {
          if(protocol.equalsIgnoreCase("NEC")) {
            irsend.sendNEC(lData, iNumBits);
          } else if(protocol.equalsIgnoreCase("RC6")) {
            irsend.sendRC6(lData, iNumBits);
          } else if(protocol.equalsIgnoreCase("RCMM")) {
              if(lData == 0x22c0260c) {
                digitalWrite(8, HIGH);
                delay(200);
                digitalWrite(8, LOW);
              } else {
                irsend.sendRCMM(lData, iNumBits);
              }
          } else if(protocol.equalsIgnoreCase("Samsung")) {
            if(lData == 1) { //Samsung ON/OFF
              unsigned int code[] = {4400,4550,450,1800,450,1800,450,700,400,700,400,750,350,750,350,1800,450,750,350,1800,450,1800,450,750,350,750,350,1850,400,750,350,1850,400,750,350,1850,400,750,350,750,400,700,400,750,350,750,350,750,350,750,350,750,400,1800,400,1850,400,1850,400,1800,450,1800,450,1800,450,1850,400};
              irsend.sendRaw(code, 67, 38);
            } else if(lData == 2) { //Samsung SOURCE
              unsigned int code[] = {4450,4550,450,1750,500,1800,450,700,400,700,450,650,450,650,450,1750,500,700,400,1750,500,1750,500,650,450,700,400,1750,500,650,450,1750,500,650,450,1750,500,650,450,650,450,700,400,1800,450,700,400,700,450,650,450,650,450,1750,500,1750,500,1750,500,650,450,1750,500,1700,500,1800,450};
              irsend.sendRaw(code, 67, 38);
            } else if(lData == 3) { //Samsung VOL UP
              unsigned int code[] = {4350,4600,450,1800,450,1800,450,650,450,650,450,650,450,650,450,1800,450,700,450,1750,450,1800,450,650,450,700,450,1750,450,700,450,1750,450,700,450,1750,450,1800,450,650,450,700,450,1750,500,1750,450,700,450,650,450,650,450,650,450,1800,450,1800,450,650,450,650,450,1800,450,1750,500};
              irsend.sendRaw(code, 67, 38);
            } else if(lData == 4) { //Samsung VOL DOWN
              unsigned int code[] = {4350,4600,450,1750,500,1750,500,650,450,700,400,700,400,700,400,1800,450,700,400,1750,500,1750,500,650,450,700,400,1800,450,700,400,1800,450,700,450,1750,450,1800,450,700,400,1800,450,1750,500,1750,500,700,400,700,400,700,450,650,450,1750,500,650,450,650,450,650,450,1750,500,1750,500};
              irsend.sendRaw(code, 67, 38);
            }
          }
        }
      }
    }

    // send a reply, to the IP address and port that sent us the packet we received
    Udp.beginPacket(Udp.remoteIP(), Udp.remotePort());
    Udp.write(ReplyBuffer);
    Udp.endPacket();
    
    for(int i=0;i<UDP_TX_PACKET_MAX_SIZE;i++) packetBuffer[i] = 0;
  }
  delay(10);
}

