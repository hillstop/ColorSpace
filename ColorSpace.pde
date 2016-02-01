import controlP5.*;
import java.awt.Color;

ControlP5 cp5;
HashMap<String, Slider> sliderMap;
float[] rgbValue;
float[] hsbValue;
color clr;

static final int rangeRGB = 255;
static final int rangeH = 360;
static final int rangeSB = 100;

void setup() {
  size(700,450);
  noStroke();
  sliderMap = new HashMap<String, Slider>();
  rgbValue = new float[3];
  hsbValue = new float[3];
  
  cp5 = new ControlP5(this);
  createSlider("red", 100, 100, rangeRGB, rangeRGB+1);
  createSlider("green", 100, 200, rangeRGB, rangeRGB+1);
  createSlider("blue", 100, 300, rangeRGB, rangeRGB+1);
  createSlider("hue", 400, 100, rangeH, rangeH+1);
  createSlider("saturation", 400, 200, rangeSB, rangeSB+1);
  createSlider("brightness", 400, 300, rangeSB, rangeSB+1);
}

void createSlider(String name, int posX, int posY, int rangeMax, int tickMark){
  sliderMap.put(name,
                cp5.addSlider(name)
                   .setPosition(posX,posY)
                   .setSize(200,50)
                   .setRange(0,rangeMax)
                   .setValue((int)(rangeMax/2))
                   .setNumberOfTickMarks(tickMark)
                   )
                   ;
  cp5.getController(name).getValueLabel().setSize(10);
  cp5.getController(name).getCaptionLabel().setSize(10);
  cp5.getController(name).getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM).setPaddingX(0);
}

void draw() {
  background(clr);

  sliderMap.get("red").setValue(rgbValue[0]);
  sliderMap.get("green").setValue(rgbValue[1]);
  sliderMap.get("blue").setValue(rgbValue[2]);

  sliderMap.get("hue").setValue(hsbValue[0]);
  sliderMap.get("saturation").setValue(hsbValue[1]);
  sliderMap.get("brightness").setValue(hsbValue[2]);
}

void red(float value){
  setClrRGB(0, value);
}
void green(float value){
  setClrRGB(1, value);
}
void blue(float value){
  setClrRGB(2, value);
}
void hue(float value){
  setClrHSB(0, value);
}
void saturation(float value){
  setClrHSB(1, value);
}
void brightness(float value){
  setClrHSB(2, value);
}

void setClrRGB(int index, float value){
  rgbValue[index] = value;
  float[] hsb_temp =Color.RGBtoHSB((int)(rgbValue[0] * (255.0 / (float)rangeRGB)), 
                                   (int)(rgbValue[1] * (255.0 / (float)rangeRGB)), 
                                   (int)(rgbValue[2] * (255.0 / (float)rangeRGB)), null);
  hsbValue[0] = hsb_temp[0] * rangeH;
  hsbValue[1] = hsb_temp[1] * rangeSB;
  hsbValue[2] = hsb_temp[2] * rangeSB;
                                                             
  colorMode(RGB, rangeRGB);
  clr = color(rgbValue[0], rgbValue[1], rgbValue[2]);
  println("RGB:index="+index+",value="+value);
}

void setClrHSB(int index, float value){
  hsbValue[index] = value;
  Color colorRGB = new Color(Color.HSBtoRGB(hsbValue[0] / rangeH, 
                                            hsbValue[1] / rangeSB, 
                                            hsbValue[2] / rangeSB));  
  rgbValue[0] = (float)colorRGB.getRed() * ((float)rangeRGB / 255.0);
  rgbValue[1] = (float)colorRGB.getGreen() * ((float)rangeRGB / 255.0);
  rgbValue[2] = (float)colorRGB.getBlue() * ((float)rangeRGB / 255.0);

  println("rgbValue="+rgbValue[0]);
  colorMode(HSB, rangeH, rangeSB, rangeSB);
  clr = color(hsbValue[0], hsbValue[1], hsbValue[2]);
  println("HSB:index="+index+",value="+value);
}