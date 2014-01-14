---
layout: blog
published: true
title: Processing Visulisation Development
excerpt: A walkthrough for how I created a weather feed visulisation in Processing for University.

date: 2011-04-01 12:44:35.000000000 +01:00
---
The concept for the data visualisation that I have produced came from the idea of how I have always seen data being presented as a child.  I took the principle of a simple bar graph and decided to show a history of several of the different pieces of information available in the feeds.  Further, I decided to implement the current windspeed into the data, but in a unique way.   I decided that the bars should all drift from left to right at the current windspeed, in order to keep the data readable I also decided that the addition of a click event should be present to pause this animation.  

### Class File

The development of the data visualisation took shape in several steps, the first of these was to develop a class file for the bars.  These objects are all pretty much the same, a rectangle.  The only ways they differentiate are in colour, height and the horizontal position.  

In order to minimise the amount of data having to be passed around, and so the amount of memory being used in turn I decided to access the data array directly from the class where needed. 

I have added additional comments into the source code below to show exactly what is going on.  

{% highlight java %}
class Bar
{

  // Variable Declaration
  int from = 0;
  float barHeight = 0;
  int barWidth = 8;
  int growSpeed = 1;
  int barHorizPos;
  color barColor;

  // Constructor, updates variables local to class with those passed in
  Bar( float theHeight, color theColor, int theHorizPos )
  {
    barHeight = theHeight;
    barHorizPos = theHorizPos;
    barColor = theColor;
  }

  // Method that actually creates and animates the bar
  void display()
  {
    
    // What the rectangle will look like
    rectMode(CORNER);
    fill(barColor);
    stroke(0);
    
    // Work out if the bar is the right height, and shrink it if it's not.  
    if (from == barHeight)
      rect(barHorizPos, (400 - barHeight), barWidth, barHeight);
    else if (from > barHeight)
    {
      from = from - growSpeed;
      rect(barHorizPos, (400 - from), barWidth, (from - growSpeed));
    }
    else if (from < barHeight)
    {
      from = from + growSpeed;
      rect(barHorizPos, (400 - from), barWidth, from);
    }
    
    // Detect is sideways movement is on or off and either move of leave accordingly 
    if ( barMove)
    {
      
      barHorizPos = barHorizPos + int(xmlData[0][0]);
      if ( barHorizPos >= 300 )
        barHorizPos = -15;
        
    }
    
  }
}
{% endhighlight %}


### Highest Value Function

In order to map the bars correctly I need to establish the highest value from each of the feeds I need to stream.  In order to do this I wrote the following function which simply returns that highest number as a float.  

{% highlight java %}
int highestValue( int index )
{
  int number = 0;
  
  if ( int(xmlData[index][0]) > int(xmlData[index][1]) && int(xmlData[index][0]) > int(xmlData[index][2]) )
    number = int(xmlData[index][0]);
      
  else if ( int(xmlData[index][1]) > int(xmlData[index][0]) && int(xmlData[index][1]) > int(xmlData[index][2]))
    number = int(xmlData[index][1]);
      
  else if ( int(xmlData[index][2]) > int(xmlData[index][0]) && int(xmlData[index][2]) > int(xmlData[index][1]))
    number = int(xmlData[index][2]);
  
  return number;
}
{% endhighlight %}

### Bar Color Function

I decided that the colour of each bar should change based on the current outside temperature.  In order to do this I decided to create a function that would generate the correct colour for each.  The function assigns a random amount of green, and uses the current temperature for the red and blue.  Finally the alpha is decreased over each bar to help show that some data is older than other pieces.  

{% highlight java %}
color barColor( int index)
{
  
  int redValue;
  int blueValue;
  
  int sumComponent = int(map( xmlData[2][0], 0, highestValue(2),0, 255));
  
  if (index == 1)
    return color(sumComponent, random(0,255), sumComponent, 200);
  else if(index == 2)
    return color(sumComponent, random(0,255), sumComponent, 255);
  else
    return color(sumComponent, random(0,255), sumComponent, 155);
  
}
{% endhighlight %}

### Main Code Block

Finally, the main block of code contains the click event, XML processing, object set-up and the draw and setup functions.  I ahve added additional comments to the source code below to explain it.  

{% highlight java %}
import processing.xml.*;

// The array contains all of the feeds that I decided to use
String[] feedLocations = { 
  "http://x2.i-dat.org/archos/archive.rss?source=.WindSpeed", 
  "http://x2.i-dat.org/archos/archive.rss?source=.OutAirHum", 
  "http://x2.i-dat.org/archos/archive.rss?source=.OutAirTemp",
  "http://x2.i-dat.org/archos/archive.rss?source=.WindVane",
  "http://x2.i-dat.org/archos/archive.rss?source=.Elec_A_YDay",
  "http://x2.i-dat.org/archos/archive.rss?source=.LT3_AirHum",
};

// This array is for holding the data once it has been converted to floats
float[][] xmlData     = new float[7][3];

// Variable needs to be public so the class file can see it, controls the sideways animation
Boolean barMove = true;

// Object array for holding the bars
Bar[] bars = new Bar[18];

void setup()
{
  // Canvas setup
  size(300,400);
  frameRate(25);
  
  // For loop for processing the feeds and populating the xmlData array with floats
  for (int f = 0; f < 6; f++)
  {
    XMLElement xml = new XMLElement(this, feedLocations[f]);
    XMLElement[] xmlValue = xml.getChildren("channel/item/description");

    for ( int g = 0; g < 3; g++)
      xmlData[f][g] = float(xmlValue[g].getContent());
  }
  
  // Variables used in order to help generate the bars
  int arrayLocation = 0;
  int position = 10;
    
  // Two-tier for loop for generating the bars, works through both levels of the array methodically creating the bars
  for (int i = 1; i < 6; i++)
  {
    
    for (int j = 0; j < 3; j++)
    {
      bars[arrayLocation] = new Bar( int(map(xmlData[i][j], 0, highestValue(i), 0, 350)), barColor(j), position );
      arrayLocation++;
      position = position + 15;
    }
    
    position = position + 15;
    
  }
  
}

// Function for drawing the bars
void draw()
{
  // Clear the canvas every frame
  background(0);

  // And then redraw all the bars in their new location
  for(int i = 0; i < 15; i++)
      bars[i].display();
}

// Click event for stopping sideways animation 
void mousePressed(MouseEvent e)
{
  if ( barMove )
    barMove = false;
  else
    barMove = true;
}
{% endhighlight %}

### Evaluation

If I had more time to do this project again I would have added protocols to deal with things such as negative numbers, these currently generate a bar of 0 height, meaning that it appears to be a brocken bar.  I would also have optimised the actual code much more so that it doesn't use so much memory when running, an would also load faster.  

This project went well in that I successfully visualised the data, and added an interactive element to the project, much of the code is also automated meaning it would be relatively easy to add more bars or change the data that is being streamed.  
