package fa {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.text.TextField; // Yeah, this is here, weird
	
	import gs.TweenMax;
	
	public class FASprite extends Sprite {
		
		// Identifier
		private var myID:int = -1;
		
		private var myTweens:Object = {};
		private var isDraggable:Boolean = false;
		
		public function FASprite (displayObjectOrProperties:* = null) {
			super();
			
			if (displayObjectOrProperties) {
				if (displayObjectOrProperties is DisplayObject) {
					
					if (displayObjectOrProperties.parent)
						displayObjectOrProperties.parent.addChild(this)
					addChild(displayObjectOrProperties);
					
				} else
					p(displayObjectOrProperties);
			}
			
		}
		
		public function set id (value:int):void {
			myID = value;
		}
		
		public function get id ():int {
			return myID;
		}
		
		// Takes a Set of properties and applies it to this sprite. Handy for x, y, alpha, etc.
		// Returns itself for chaining
		public function p (properties:Object):* {
			for (var key:* in properties)
				this[key] = properties[key];
			return this;
		}
		
		// Useful in the Flash IDE
		static public function wrap (element:DisplayObject):FASprite {
			return new FASprite(element);
		}
		
		
		// Children --------------------
		
		public function addChildren (children:Array):* {
			for (var i:uint = 0; i < children.length; i++)
				addChild(children[i]);
			return this;
		}
		
		public function set child (aChild:DisplayObject):void {
			addChild(aChild);
		}
		
		public function set children (theChildren:Array):void {
			addChildren(theChildren);
		}
		
		public function set childOf (parent:DisplayObjectContainer):void {
			parent.addChild(this);
		}
		
		public function removeAllChildren ():* {
			for (var i:int = numChildren-1; i > -1; i--)
				removeChildAt(i);
			return this;
		}
		
		public function moveToTop ():* {
			this.parent.setChildIndex(this, this.parent.numChildren-1);
			return this;
		}
		
		public function moveToBottom ():* {
			this.parent.setChildIndex(this, 0);
			return this;
		}
		
		
		// Shorthand --------------------
		
		public function show ():* {
			if (hasTween('show')) {
				this.visible = true;
				tween('show', forceShow);
			} else
				this.visible = true;
			return this;
		}
		
		public function hide ():* {
			if (hasTween('hide'))
				tween('hide', forceHide);
			else
				this.visible = false;
			return this;
		}
		
		
		// Shorthand Events --------------------
		
		public function click (listener:Function, addCursorOptions:Boolean = true):* {
			if (addCursorOptions) {
				buttonMode = true;
				useHandCursor = true;
			}
			this.addEventListener(MouseEvent.CLICK, listener);
			return this;
		}
		
		public function dissolveClick (listener:Function):* {
			this.removeEventListener(MouseEvent.CLICK, listener);
			return this;
		}
		
		public function over (listener:Function):* {
			this.addEventListener(MouseEvent.ROLL_OVER, listener);
			return this;
		}
		
		public function out (listener:Function):* {
			this.addEventListener(MouseEvent.ROLL_OUT, listener);
			return this;
		}
		
		public function hover (overListener:Function, outListener:Function):* {
			return over(overListener).out(outListener);
		}
		
		public function down (listener:Function):* {
			this.addEventListener(MouseEvent.MOUSE_DOWN, listener);
			return this;
		}
		
		public function up (listener:Function):* {
			this.addEventListener(MouseEvent.MOUSE_UP, listener);
			return this;
		}
		
		public function move (listener:Function):* {
			this.addEventListener(MouseEvent.MOUSE_MOVE, listener);
			return this;
		}
		
		public function added (listener:Function):* {
			this.addEventListener(Event.ADDED, listener);
			return this;
		}
		
		
		// Effect Events --------------------
		
		public function clickEffect (duration:Number, props:Object):* {
			return click(function (event:MouseEvent):void {
				TweenMax.killTweensOf(event.target);
				TweenMax.to(event.target, duration, props);
			});
		}
		
		public function overEffect (duration:Number, props:Object):* {
			return over(function (event:MouseEvent):void {
				TweenMax.killTweensOf(event.target);
				TweenMax.to(event.target, duration, props);
			});
		}
		
		public function outEffect (duration:Number, props:Object):* {
			return out(function (event:MouseEvent):void {
				TweenMax.killTweensOf(event.target);
				TweenMax.to(event.target, duration, props);
			});
		}
		
		public function hoverEffect (duration:Number, overProps:Object, outProps:Object):* {
			return overEffect(duration, overProps).outEffect(duration, outProps);
		}
		
		
		// Custom Tweens --------------------
		
		// Define a custom effect
		public function addTween (name:String, duration:Number, props:Object, killTweens:Boolean = true):* {
			myTweens[name] = {
				duration:duration,
				props:props,
				killTweens:killTweens
			};
			return this;
		}
		
		// Execute a custom tween
		public function tween (name:String, onComplete:Function = null):* {
			if (hasTween(name)) {
				if (myTweens[name].killTweens)
					TweenMax.killTweensOf(this);
				
				if (onComplete != null)
					myTweens[name].props.onComplete =  onComplete;
				
				TweenMax.to(this, myTweens[name].duration, myTweens[name].props);
			}
			return this;
		}
		
		public function hasTween (name:String):Boolean {
			return (myTweens.hasOwnProperty(name));
		}
		
		public function addShowTween (duration:Number, props:Object, killTweens:Boolean = true):* {
			return addTween('show', duration, props, killTweens);
		}
		
		public function addHideTween (duration:Number, props:Object, killTweens:Boolean = true):* {
			return addTween('hide', duration, props, killTweens);
		}
		
		// Draggable --------------------
		
		public function set draggable (value:Boolean):void {
			isDraggable = value;
			if (isDraggable)
				down(onDragDown).up(onDragUp);
		}
		
		public function get draggable ():Boolean {
			return isDraggable;
		}
		
		private function onDragDown (e:Event):void {
			this.startDrag(false);
		}
		
		private function onDragUp (e:Event):void {
			this.stopDrag();
		}
		
		
		// Transformations --------------------
		
		public function flip (direction:String = 'horizontal'):* {
			
			var matrix:Matrix = this.transform.matrix;
			
			if (direction == 'horizontal') {
				matrix.a = -1;
				matrix.tx = this.width + this.x;
			} else {
				matrix.d = -1;
				matrix.ty = this.height + this.y;
			}
			
			this.transform.matrix = matrix;
			
			return this;
		}
		
		
		// Anchors --------------------
		
		public function center ():* {
			return p({x:-this.width/2, y:-this.height/2});
		}
		
		public function centerWith (parent:DisplayObject):* {
			return p({x:parent.width/2 - this.width/2, y:parent.height/2 - this.height/2});
		}
		
		public function centerWithParent ():* {
			return (parent) ? centerWith(parent) : this;
		}
		
		public function anchorTopLeft ():* {
			return p({x:0, y:0});
		}
		
		public function anchorTopRight ():* {
			return p({x:x-width, y:0});
		}
		
		public function anchorBottomLeft ():* {
			return p({x:0, y:y-height});
		}
		
		public function anchorBottomRight ():* {
			return p({x:x-width, y:y-height});
		}
		
	}
	
}