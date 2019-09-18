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



class Design_1_1_DieWhenHit extends ActorScript
{
	public var _health:Float;
	public var _maxHealth:Float;
	public var _killed:Bool;
	public var _AmountToAdd:Float;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("health", "_health");
		_health = 0.0;
		nameMap.set("maxHealth", "_maxHealth");
		_maxHealth = 0.0;
		nameMap.set("killed", "_killed");
		_killed = false;
		nameMap.set("Amount To Add", "_AmountToAdd");
		_AmountToAdd = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_health = _maxHealth;
		
		/* ======================== Something Else ======================== */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				/* See 'Explode on Death' behavior to see the logic for HandleDeath. */
				actor.setFilter([createTintFilter(Utils.getColorRGB(255,51,51), 10/100)]);
				if(!(_health == 0))
				{
					_health = (_health - 1);
					recycleActor(actor.getLastCollidedActor());
				}
				else
				{
					_killed = true;
					Engine.engine.setGameAttribute("Money", ((Engine.engine.getGameAttribute("Money") : Float) + _AmountToAdd));
					actor.shout("_customEvent_" + "HandleDeath");
					recycleActor(actor.getLastCollidedActor());
					setValueForScene("CheckForSceneEnd", "_NumberKilled", (asNumber(getValueForScene("CheckForSceneEnd", "_NumberKilled")) + 1));
					recycleActor(actor);
				}
				runLater(1000 * 0.1, function(timeTask:TimedTask):Void
				{
					actor.clearFilters();
				}, actor);
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}