FA Actionscript 3 Library
=========================

FA-AS3 was created to shorten the creation and manipulation of Sprites. I found that I loved how you can chain methods with jQuery's and wanted to do something similar for AS3.


## Instead of writing this ##

var mySprite:Sprite = new Sprite();

mySprite.x = 100;

mySprite.y = 100;

mySprite.alpha = 0.5;

addChild(mySprite);

mySprite.addEventListener(MouseEvent.CLICK, onClick); // don't forget to add import statements!

mySprite.addEventListener(MouseEvent.MOUSE_OVER, onOver);

mySprite.addEventListener(MouseEvent.MOUSE_OUT, onOut);


## Now you can do it like this ##

import fa.FASprite;

var faSprite:FASprite = new FASprite({x:100, y:100, alpha:0.5, childOf:this}).click(onClick).hover(onOver, onOut);

That's it! Sprite creation and manipulation just got 10x faster.


## Effects ##

FA-AS3 supports effects and tweens by utilizing [TweenMax](http://tweenmax.com)

Add some TweenMax effects

faSprite.clickEffect(1, {scale:2}).hoverEffect(0.5, {alpha:1}, {alpha:0.5});


Store some tweens to be executed later

faSprite.addTween('moveRight', 1, {x:100});


Execute stored tween
faSprite.tween('moveRight');


## Props ##

It also supports a .p(Object) function (same as the constructor):

faSprite.p({rotationX:90});


A few interesting things to do with .p()

faSprite.p({children:[spriteA, spriteB], childOf:spriteC});


## Even More ##

There are many more methods written to extend the core, just read the source to see what's hidden.


## Requirements ##

You'll need a reference to [TweenMax](http://tweenmax.com), otherwise you'll need to fork this and rip it out.


## Contributors ##
  * [Caleb Wright](http://fabrikagency.com)


## License ##
(The MIT License)

Copyright © 2009 Fabrik Agency

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.