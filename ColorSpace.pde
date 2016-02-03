import controlP5.*;
import java.awt.Color;

static final int[] rgbRange = {255, 255, 255};
static final int[] hsbRange = {360, 100, 100};
ControlP5 cp5;
HashMap<String, Slider> sliderMap;
float[] rgbValue;
float[] hsbValue;
color clr;

void setup() {
  size(700,450);
  noStroke();
  sliderMap = new HashMap<String, Slider>();
  rgbValue = new float[3];
  hsbValue = new float[3];

  cp5 = new ControlP5(this);
  createSlider("red", 100, 100, rgbRange[0], rgbRange[0]*5+1);
  createSlider("green", 100, 200, rgbRange[1], rgbRange[1]*5+1);
  createSlider("blue", 100, 300, rgbRange[2], rgbRange[2]*5+1);
  createSlider("hue", 400, 100, hsbRange[0], hsbRange[0]*5+1);
  createSlider("saturation", 400, 200, hsbRange[1], hsbRange[1]*5+1);
  createSlider("brightness", 400, 300, hsbRange[2], hsbRange[2]*5+1);
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
  setColorRGB(0, value);
}
void green(float value){
  setColorRGB(1, value);
}
void blue(float value){
  setColorRGB(2, value);
}
void hue(float value){
  setColorHSB(0, value);
}
void saturation(float value){
  setColorHSB(1, value);
}
void brightness(float value){
  setColorHSB(2, value);
}

void setColorRGB(int index, float value){
  rgbValue[index] = value;
  colorMode(RGB, rgbRange[0], rgbRange[1], rgbRange[2]);
  clr = color(rgbValue[0], rgbValue[1], rgbValue[2]);
  
  hsbValue = RGBtoHSB(rgbValue);
}

float[] RGBtoHSB(float[] rgb){
  float[] hsb = new float[3];
  float[] hsb_temp = Color.RGBtoHSB((int)(rgb[0] * (255.0 / (float)rgbRange[0])), 
                                   (int)(rgb[1] * (255.0 / (float)rgbRange[1])), 
                                   (int)(rgb[2] * (255.0 / (float)rgbRange[2])), null);
  hsb[0] = (hsb_temp[0] * (float)hsbRange[0]);
  hsb[1] = (hsb_temp[1] * (float)hsbRange[1]);
  hsb[2] = (hsb_temp[2] * (float)hsbRange[2]);                                                             
  return hsb;
}

void setColorHSB(int index, float value){
  hsbValue[index] = value;
  colorMode(HSB, hsbRange[0], hsbRange[1], hsbRange[2]);
  clr = color(hsbValue[0], hsbValue[1], hsbValue[2]);
  
  rgbValue = HSBtoRGB(hsbValue);
}

float[] HSBtoRGB(float[] hsb){
  float[] rgb = new float[3];
  Color colorRGB = new Color(Color.HSBtoRGB(hsb[0] / (float)hsbRange[0], 
                                            hsb[1] / (float)hsbRange[1], 
                                            hsb[2] / (float)hsbRange[2]));  
  rgb[0] = ((float)colorRGB.getRed() * ((float)rgbRange[0] / 255.0));
  rgb[1] = ((float)colorRGB.getGreen() * ((float)rgbRange[1] / 255.0));
  rgb[2] = ((float)colorRGB.getBlue() * ((float)rgbRange[2] / 255.0));
  return rgb;
}