//www.elegoo.com
//2016.09.23

#include <Servo.h> //servo library
Servo myservo; // create servo object to control servo
int Echo = A4;  
int Trig = A5; 
int in1 = 6;
int in2 = 7;
int in3 = 8;
int in4 = 9;
int ENA = 5;
int ENB = 11;
int ABS = 150;
int angle = 0, distLeft = 0, distRight = 0;
int turnDelay = 650;
int bias = 0;

/*//Our car
int SENSE_LEFT=2;
int SENSE_CENTER=4;
int SENSE_RIGHT=10;
*/

//borrowed car
int SENSE_LEFT=10;
int SENSE_CENTER=4;
int SENSE_RIGHT=2;


bool LIGHT=false;
bool DARK=true;

void forward()
{
 analogWrite(ENA,ABS);
 analogWrite(ENB,ABS);
  digitalWrite(in1,HIGH);//digital output
  digitalWrite(in2,LOW);
  digitalWrite(in3,LOW);
  digitalWrite(in4,HIGH);
 Serial.println("go forward!");
}

void back()
{
 right90();
 right90();
 Serial.println("go back!");
}

void left90()
{
 bias -= 1;
 analogWrite(ENA,ABS);
 analogWrite(ENB,ABS);
  digitalWrite(in1,HIGH);
  digitalWrite(in2,LOW);
  digitalWrite(in3,HIGH);
  digitalWrite(in4,LOW); 
 delay(turnDelay);
 Serial.println("go left!");
}

void right90()
{
 bias += 1;
 analogWrite(ENA,ABS);
 analogWrite(ENB,ABS);
  digitalWrite(in1,LOW);
  digitalWrite(in2,HIGH);
  digitalWrite(in3,LOW);
  digitalWrite(in4,HIGH);
 delay(turnDelay);
 Serial.println("go right!");
} 
void right()
{
 analogWrite(ENA,ABS);
 analogWrite(ENB,ABS);
  digitalWrite(in1,LOW);
  digitalWrite(in2,LOW);
  digitalWrite(in3,LOW);
  digitalWrite(in4,HIGH);
 Serial.println("go right!");
} 
void left()
{
 analogWrite(ENA,ABS);
 analogWrite(ENB,ABS);
  digitalWrite(in1,HIGH);
  digitalWrite(in2,LOW);
  digitalWrite(in3,LOW);
  digitalWrite(in4,LOW);
 Serial.println("go left!");
}
void halt()
{
  digitalWrite(ENA,LOW);
  digitalWrite(ENB,LOW);
  Serial.println("Stop!");
} 
 /*Ultrasonic distance measurement Sub function*/
int Distance_test()   
{
  digitalWrite(Trig, LOW);   
  delayMicroseconds(2);
  digitalWrite(Trig, HIGH);  
  delayMicroseconds(20);
  digitalWrite(Trig, LOW);   
  float Fdistance = pulseIn(Echo, HIGH);  
  Fdistance= Fdistance/58;       
  return (int)Fdistance;
}  

void setup() 
{ 
  myservo.attach(3);// attach servo on pin 3 to servo object
  Serial.begin(9600);     
  pinMode(Echo, INPUT);    
  pinMode(Trig, OUTPUT);  
  pinMode(in1,OUTPUT);
  pinMode(in2,OUTPUT);
  pinMode(in3,OUTPUT);
  pinMode(in4,OUTPUT);
  pinMode(ENA,OUTPUT);
  pinMode(ENB,OUTPUT);
  pinMode(SENSE_LEFT,INPUT);
  pinMode(SENSE_CENTER,INPUT);
  pinMode(SENSE_RIGHT,INPUT);
  analogWrite(ENA,ABS);       
  analogWrite(ENB,ABS);
  halt();
} 

void loop() {
  //TODO: Make decision on direction at intersections (both color sensors tripped)
  //TODO: Include forward sonar in decision
  //TODO: Implement bias
  if(Distance_test() < 15){
    halt();
    angle = 180;
    myservo.write(180);
    delay(500);
    distLeft = Distance_test();
    Serial.println(distLeft);
    delay(100);
    angle = 0;
    myservo.write(0);
    delay(500);
    distRight = Distance_test();
    Serial.println(distRight);
    delay(100);
    if(distRight > 15) {
      right90();
    }else if(distLeft > 15) {
      left90();
    }else {
      back();
    }
  }
  if(angle != 90) {
    halt();
    angle = 90;
    myservo.write(angle);
    delay(1000);
  }
  //delay(100);
  int senseLeft = digitalRead(SENSE_LEFT);
  int senseRight = digitalRead(SENSE_RIGHT);
  if(senseLeft==DARK) {
    Serial.println("GO LEFT"); 
    right();
    //_mleft();
    delay(15);
  }else if(senseRight==DARK) {
    Serial.println("GO RIGHT");
    left();
    //_mright();
    delay(15);
  }else{
    forward();
  }
}

