const int numReadings1 = 10;
int readings1[numReadings1];      
int readIndex1 = 0;              
int total1 = 0;                  
int average1 = 0;                
const int numReadings2 = 10;
int readings2[numReadings2];      
int readIndex2 = 0;              
int total2 = 0;                  
int average2 = 0;                
const int numReadings3 = 10;
int readings3[numReadings3];      
int readIndex3 = 0;    
int total3 = 0;                 
int average3 = 0;  
const int numReadings4 = 10;
int readings4[numReadings4];     
int readIndex4 = 0;              
int total4 = 0;                  
int average4 = 0;  
float sensorValue = 0;
unsigned long previousMillis = 0;   
const long interval = 100; 
#include <HX711.h>
#include <Servo.h>
#define calibration_factor1 -32000
#define calibration_factor2 -5700 
#define calibration_factor3 -5700
#define calibration_factor4 -32000
#define DOUT1  3
#define CLK1  2
#define DOUT2  5
#define CLK2  4
#define DOUT3  7
#define CLK3  6
#define DOUT4  13
#define CLK4  12
HX711 scale1(DOUT1, CLK1);
HX711 scale2(DOUT2, CLK2);
HX711 scale3(DOUT3, CLK3);
HX711 scale4(DOUT4, CLK4);
Servo servo1;
Servo servo2;
Servo servo3;
void setup() {
  Serial.begin(9600);
    for (int thisReading1 = 0; thisReading1 < numReadings1; thisReading1++) {
    readings1[thisReading1] = 0;
  }
    for (int thisReading2 = 0; thisReading2 < numReadings2; thisReading2++) {
    readings2[thisReading2] = 0;
  }
    for (int thisReading3 = 0; thisReading3 < numReadings3; thisReading3++) {
    readings3[thisReading3] = 0;
  }
      for (int thisReading4 = 0; thisReading4 < numReadings4; thisReading4++) {
    readings4[thisReading4] = 0;
  }
   scale1.set_scale(calibration_factor1); 
  scale1.tare(); 
  scale2.set_scale(calibration_factor2); 
  scale2.tare(); 
  scale3.set_scale(calibration_factor3); 
  scale3.tare();
      scale4.set_scale(calibration_factor4); 
  scale4.tare();
servo1.attach(9);
servo2.attach(10);
servo3.attach(11);
}
void loop() {
unsigned long currentMillis = millis();
  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;  
     /*
   Serial.print(scale1.get_units(),2);
   Serial.print(",");
// Serial.print("UZGONL ");
 Serial.print(scale2.get_units(),2);
  Serial.print(",");
//  Serial.print("UZGOND");
 Serial.print(scale3.get_units(),2);
   Serial.println(",");
}*/
  total1 = total1 - readings1[readIndex1];
  readings1[readIndex1] = scale1.get_units()*10;
  total1 = total1 + readings1[readIndex1];
  readIndex1 = readIndex1 + 1;
  if (readIndex1 >= numReadings1) {
    readIndex1 = 0;
  }
  average1 = total1 / numReadings1;
 // Serial.println(average1);
 // delay(1);   
    total2 = total2 - readings2[readIndex2];
  readings2[readIndex2] = scale2.get_units()*10;
  total2 = total2 + readings2[readIndex2];
  readIndex2 = readIndex2 + 1;
  if (readIndex2 >= numReadings2) {
    readIndex2 = 0;
  }
  average2 = total2 / numReadings2;
 // Serial.println(average2);
 // delay(1);   
    total3 = total3 - readings3[readIndex3];
  readings3[readIndex3] = scale3.get_units()*10;
  total3 = total3 + readings3[readIndex3];
  readIndex3 = readIndex3 + 1;
  if (readIndex3 >= numReadings3) {
    readIndex3 = 0;
  }
  average3 = total3 / numReadings3;
 // Serial.println(average3);
 // delay(1);
  total4 = total4 - readings4[readIndex4];
  readings4[readIndex4] = scale4.get_units()*10;
  total4 = total4 + readings4[readIndex4];
  readIndex4 = readIndex4 + 1;
  if (readIndex4 >= numReadings4) {
    readIndex4 = 0;
  }
  average4 = total4 / numReadings4; 
Serial.print(average1);
Serial.print(",");
Serial.print(average2);
Serial.print(",");
Serial.print(average3);
Serial.print(",");
Serial.println(average4);
 }
static int v = 0;
if (Serial.available()) {
  char ch = Serial.read();
 switch(ch) {
  case '0'...'9':
  v=v*10+ch-'0';
  break;
  case 'a':
  servo1.write(v);
//  Serial.println(v);
  v=0;
  break;
  case 'b' :
  servo3.write(v);
  servo2.write(abs(v-180));
//  Serial.println(v);
  v=0;
  break;
   case 'k' :
  scale1.tare();  
  scale2.tare();
  scale3.tare();
  scale4.tare();
    v=0;
  break;
  }}}
