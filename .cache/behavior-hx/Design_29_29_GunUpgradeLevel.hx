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



class Design_29_29_GunUpgradeLevel extends ActorScript
{
	public var _Gun0:Actor;
	public var _Gun1:Actor;
	public var _Gun2:Actor;
	public var _Self:Actor;
	public var _LocalUpdated:Bool;
	public var _UpgradeOnce:Bool;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Gun0", "_Gun0");
		nameMap.set("Gun1", "_Gun1");
		nameMap.set("Gun2", "_Gun2");
		nameMap.set("Self", "_Self");
		nameMap.set("LocalUpdated", "_LocalUpdated");
		_LocalUpdated = false;
		nameMap.set("Upgrade Once", "_UpgradeOnce");
		_UpgradeOnce = false;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		createRecycledActor(getActorType(33), actor.getX(), actor.getY(), Script.BACK);
		_Gun0 = getLastCreatedActor();
		propertyChanged("_Gun0", _Gun0);
		_Self = actor;
		propertyChanged("_Self", _Self);
		_Gun0.setValue("FollowActor", "_FollowX", actor.getX());
		_Gun0.setValue("FollowActor", "_FollowY", actor.getY());
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_LocalUpdated = (Engine.engine.getGameAttribute("GunUpgraded") : Bool);
				propertyChanged("_LocalUpdated", _LocalUpdated);
				if(((Engine.engine.getGameAttribute("GunUpgraded") : Bool) == false))
				{
					if(((actor.getValue("TankHitByBullet", "_dead") == true) && !(_Gun0 == null)))
					{
						recycleActor(_Gun0);
					}
					_Gun0.setValue("FollowActor", "_FollowX", actor.getX());
					_Gun0.setValue("FollowActor", "_FollowY", actor.getY());
				}
				if(((Engine.engine.getGameAttribute("GunUpgraded") : Bool) == true))
				{
					if(((actor.getValue("TankHitByBullet", "_dead") == true) && !(_Gun1 == null)))
					{
						recycleActor(_Gun1);
					}
					_Gun1.setValue("FollowActor", "_FollowX", actor.getX());
					_Gun1.setValue("FollowActor", "_FollowY", actor.getY());
				}
			}
		});
		
		/* =========================== Boolean ============================ */
		addPropertyChangeListener("_LocalUpdated", null, function(property:Dynamic, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && cast(property, Bool) == true)
			{
				if(!(_Gun0 == null))
				{
					if((_UpgradeOnce == false))
					{
						trace("Upgraded once");
						createRecycledActor(getActorType(35), actor.getX(), actor.getY(), Script.BACK);
						_Gun1 = getLastCreatedActor();
						propertyChanged("_Gun1", _Gun1);
						_Self = actor;
						propertyChanged("_Self", _Self);
						_Gun0.setValue("FollowActor", "_FollowX", actor.getX());
						_Gun0.setValue("FollowActor", "_FollowY", actor.getY());
						recycleActor(_Gun0);
						_UpgradeOnce = true;
						propertyChanged("_UpgradeOnce", _UpgradeOnce);
					}
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}