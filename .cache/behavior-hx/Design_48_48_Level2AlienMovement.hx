package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;
import com.stencyl.graphics.ScaleMode;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Config;
import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.motion.*;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_48_48_Level2AlienMovement extends ActorScript
{
	public var _speed:Float;
	public var _InitialDirection:Float;
	public var _dead:Bool;
	public var _closeToBottom:Float;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("speed", "_speed");
		_speed = 0.0;
		nameMap.set("Initial Direction", "_InitialDirection");
		_InitialDirection = 0.0;
		nameMap.set("dead", "_dead");
		_dead = false;
		nameMap.set("closeToBottom", "_closeToBottom");
		_closeToBottom = 50.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		actor.setVelocity(_InitialDirection, _speed);
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((actor.getX() <= 2))
				{
					actor.setVelocity(180, _speed);
				}
				if(((actor.getX() + (actor.getWidth())) >= (getSceneWidth() - 2)))
				{
					actor.setVelocity(0, _speed);
				}
				if((actor.getY() >= _closeToBottom))
				{
					trace(actor.getY());
					_closeToBottom = (_closeToBottom + 15);
					actor.setYVelocity(0);
				}
				if((actor.getY() >= (getSceneHeight() - 159)))
				{
					_dead = true;
					reloadCurrentScene(createFadeOut(0.3), createFadeIn(0.3));
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}