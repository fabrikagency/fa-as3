FA Actionscript 3 Library
=========================

The FA library was created to shorten the creation and manipulation of Sprites.


# Instead of writing this #

var mySprite:Sprite = new Sprite();
mySprite.x = 100;
mySprite.y = 100;
mySprite.alpha = 0.5;
addChild(mySprite);

mySprite.addEventListener(MouseEvent.CLICK, onClick); // don't forget to add import statements!
mySprite.addEventListener(MouseEvent.MOUSE_OVER, onOver);
mySprite.addEventListener(MouseEvent.MOUSE_OUT, onOut);

# Now you can do it like this #
var faSprite:FASprite = new FASprite({x:100, y:100, alpha:0.5, childOf:this}).click(onClick).hover(onOver, onOut);

That's it!


## Chainability ##

## Contributors ##
  * [Caleb Wright](http://fabrikagency.com)
