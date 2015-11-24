#include <LiquidCrystal.h>
LiquidCrystal lcd(8, 9, 4, 5, 6, 7);
#define analogPin      1          // analog pin for measuring capacitor voltage
#define chargePin      3         // pin to charge the capacitor - connected to one end of the charging resistor
#define dischargePin   2         // pin to discharge the capacitor
#define resistorValue  10000.0F   // change this to whatever resistor value you are using
                                  // F formatter tells compliler it's a floating point value

unsigned long startTime;
unsigned long elapsedTime;
float microFarads;                // floating point variable to preserve precision, make calculations
float nanoFarads;

void setup(){
  lcd.begin(16, 2);
  pinMode(chargePin, OUTPUT);     // set chargePin to output
  digitalWrite(chargePin, LOW); 
   lcd.clear();
   lcd.setCursor(0, 1);
    lcd.print("Range:1nF-999uF");     

}

void loop(){
  digitalWrite(chargePin, HIGH);  // set chargePin HIGH and capacitor charging
  startTime = millis();

  while(analogRead(analogPin) < 648){       // 647 is 63.2% of 1023, which corresponds to full-scale voltage 
  }
 
  elapsedTime= millis() - startTime;
 // convert milliseconds to seconds ( 10^-3 ) and Farads to microFarads ( 10^6 ),  net 10^3 (1000)  
  microFarads = ((float)elapsedTime / resistorValue) * 1000;   
if (elapsedTime > 10){
 
}
else
{

}

  if (microFarads > 1){
    
 lcd.setCursor(0, 0);
    lcd.print(microFarads);       // print the value to serial port
 lcd.setCursor(6, 0);
    lcd.print(" uF");         // print units and carriage return
  }
  

  else 
  {
    // if value is smaller than one microFarad, convert to nanoFarads (10^-9 Farad). 
    // This is  a workaround because Serial.print will not print floats

    nanoFarads = microFarads * 1000.0;      // multiply by 1000 to convert to nanoFarads (10^-9 Farads)
 
  lcd.setCursor(0, 0);
    lcd.print(nanoFarads);         // print the value to serial port
 lcd.setCursor(6, 0);
    lcd.print(" nF ");          // print units and carriage return
  }
  
  

  /* dicharge the capacitor  */
  digitalWrite(chargePin, LOW);             // set charge pin to  LOW 
  pinMode(dischargePin, OUTPUT);            // set discharge pin to output 
  digitalWrite(dischargePin, LOW);          // set discharge pin LOW 
  while(analogRead(analogPin) > 0){         // wait until capacitor is completely discharged
  }

  pinMode(dischargePin, INPUT);            // set discharge pin back to input
} 
