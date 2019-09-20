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



class Design_52_52_TankHitByBullet extends ActorScript
{
	public var _health:Float;
	public var _trueHealth:Float;
	public var _dead:Bool;
	public var _DeathAnimation:String;
	public var _localMoney:Float;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("health", "_health");
		_health = 0.0;
		nameMap.set("trueHealth", "_trueHealth");
		_trueHealth = 0.0;
		nameMap.set("dead", "_dead");
		_dead = false;
		nameMap.set("Death Animation", "_DeathAnimation");
		nameMap.set("localMoney", "_localMoney");
		_localMoney = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_localMoney = (Engine.engine.getGameAttribute("Money") : Float);
		propertyChanged("_localMoney", _localMoney);
		_trueHealth = _health;
		propertyChanged("_trueHealth", _trueHealth);
		_dead = false;
		propertyChanged("_dead", _dead);
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(57), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				trace("Tank hit by bullet");
				recycleActor(event.otherActor);
				playSound(getSound(78));
				startShakingScreen(2 / 100, .2);
				if(!(_trueHealth == 0))
				{
					_trueHealth = (_trueHealth - 1);
					propertyChanged("_trueHealth", _trueHealth);
				}
			}
		});
		
		/* =========================== Boolean ============================ */
		addPropertyChangeListener("_dead", null, function(property:Dynamic, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && cast(property, Bool) == true)
			{
				actor.setXVelocity(0);
				actor.setAnimation(_DeathAnimation);
				actor.disableBehavior("2 Way Control");
				runLater(1000 * 2, function(timeTask:TimedTask):Void
				{
					Engine.engine.setGameAttribute("Money", _localMoney);
					reloadCurrentScene(createFadeOut(0.3), createFadeIn(0.3));
				}, actor);
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(((_trueHealth == 0) && (_dead == false)))
				{
					_dead = true;
					propertyChanged("_dead", _dead);
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}