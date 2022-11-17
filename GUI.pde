import processing.serial.*;
import controlP5.*;
ControlP5 cp5;
Textlabel myTextlabelA;
Textlabel myTextlabelB;
Textlabel myTextlabelC;
Textlabel myTextlabelD;
Textlabel myTextlabelE;
Textlabel myTextlabelF;
Textlabel myTextlabelG;
Textlabel myTextlabelH;
Textlabel myTextlabelI;
  float redValue = 0;        
  float greenValue = 0;
  float blueValue = 0;  
int myColor = color(255);
int c1,c2;
float n,n1;
int Servo = 10;
int Strujanje = 10;
Serial port;
void setup() {
frameRate(11);
 size(700,400);
  noStroke();
  println(Serial.list());
  port = new Serial(this, Serial.list()[0], 9600);
  port.bufferUntil('\n');
  port.clear();
  cp5 = new ControlP5(this);
  cp5.addButton("Kalibracija")
     .setValue(0)
     .setPosition(460,70)
     .setSize(100,50);
    cp5.addButton("colorB")
     .setValue(100)
     .setPosition(100,120)
     .setSize(200,19)
     .hide();
    myTextlabelA = cp5.addTextlabel("label1")
                    .setText("OTPOR-D")
                    .setPosition(350,200)
                    .setColorValue(0xffffff00)
                    .setFont(createFont("Georgia",20));
                               myTextlabelH = cp5.addTextlabel("label9")
                    .setText("OTPOR-L")
                    .setPosition(480,200)
                    .setColorValue(0xffffff00)
                    .setFont(createFont("Georgia",20));
                     myTextlabelI = cp5.addTextlabel("label10")
                    .setText("UKUPAN OTPOR")
                    .setPosition(350,300)
                    .setColorValue(0xffffff00)
                    .setFont(createFont("Georgia",20));
                      myTextlabelB = cp5.addTextlabel("label2")
                    .setText("UZGON-L")
                    .setPosition(200,200)
                    .setColorValue(0xffffff00)
                    .setFont(createFont("Georgia",20));
                      myTextlabelC = cp5.addTextlabel("label3")
                    .setText("UZGON-D")
                    .setPosition(50,200)
                    .setColorValue(0xffffff00)
                    .setFont(createFont("Georgia",20));
                       myTextlabelD = cp5.addTextlabel("label4")
                    .setText("UKUPAN UZGON")
                    .setPosition(50,300)
                    .setColorValue(0xffffff00)
                    .setFont(createFont("Georgia",20));
                        myTextlabelE = cp5.addTextlabel("label5")
                    .setText("FINESA")
                    .setPosition(230,300)
                    .setColorValue(0xffffff00)
                    .setFont(createFont("Georgia",20));
                                             myTextlabelE = cp5.addTextlabel("label6")
                    .setText("Zračni tunel")
                    .setPosition(70,20)
                    .setColorValue(0xffffff00)
                    .setFont(createFont("Georgia",28));
                                              myTextlabelF = cp5.addTextlabel("label7")
                    .setText("Student: Ivor Šantak")
                    .setPosition(563,370)
                    .setColorValue(0)
                    .setFont(createFont("Georgia",9));
                          myTextlabelG = cp5.addTextlabel("label8")
                    .setText("Mentor: prof.dr.sc.Marija Živić")
                    .setPosition(563,380)
                    .setColorValue(0)
                    .setFont(createFont("Georgia",9));
                     cp5.addSlider("Servo")
     .setPosition(50,70)
     .setSize(300, 30)
     .setRange(0,60)
     .setValue(0);  
  cp5.addSlider("Strujanje")
     .setPosition(50,130)
     .setSize(300,30)
     .setRange(51,80)
     .setValue(50);}
void draw() {
background(myColor);
  myColor = lerpColor(c1,c2,n);
  n += (1-n)* 0.1; 
  port.write("a"+Servo);
  port.write("b"+Strujanje);
  println("a"+Servo);
  println("b"+Strujanje);
    String inString = port.readStringUntil('\n');
 if (inString != null) {
      // trim off any whitespace:
 inString = trim(inString);
      
      float[] colors = float(split(inString, ","));
      if (colors.length >= 3) {
        String ol = str(-colors[0]/10);
        String ul = str(-colors[1]/10);
        String ud = str(-colors[2]/10);
        String od = str(colors[3]/10);
        String uku= nf((-colors[1]/10-colors[2]/10),1,2);
        String uko= nf((-colors[0]/10+colors[3]/10),1,2);
        String fin= nf((-colors[1]/10-colors[2]/10)/((-colors[0]/10+colors[3]/10)),1,2);
       println("OTPORL"+ol);
       println("OTPORD"+od);
       println("LUZGON"+ul);
       println("DUZGON"+ud);
  cp5 = new ControlP5(this);
textSize(32);
text(od, 500, 270); 
textSize(32);
text(ol, 350, 270); 
textSize(32);
text(ul, 220, 270);
textSize(32);
text(ud, 70, 270);
textSize(32);
text(uku, 70, 350);
textSize(32);
text(fin, 240, 350);
textSize(32);
text(uko, 370, 350);  }}}
    public void controlEvent(ControlEvent theEvent) {
  println(theEvent.getController().getName());
 // n = 0;}
public void Kalibracija(int theValue) {
  println("k"/*+theValue*/);
  port.write("k");
  c1 = c2;
  c2 = color(0,160,100);}
public void colorB(int theValue) {
  println("a button event from colorB: "+theValue);
  c1 = c2;
  c2 = color(150,0,0);}
