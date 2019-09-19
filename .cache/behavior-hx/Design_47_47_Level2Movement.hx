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
import box2D.collision.shapes.B2Shape;

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



class Design_47_47_Level2Movement extends SceneScript
{
	public var _Wave1Num:Float;
	public var _Wave1PosY:Float;
	public var _Wave1PosX:Float;
	public var _Wave1AlienToSpawn:ActorType;
	public var _Wave1Amount:Float;
	public var _interval:Float;
	public var _lastAlien:Actor;
	public var _alienSpeed:Float;
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("Wave 1 Num", "_Wave1Num");
		_Wave1Num = 0;
		nameMap.set("Wave 1 Pos Y", "_Wave1PosY");
		_Wave1PosY = 0;
		nameMap.set("Wave 1 Pos X", "_Wave1PosX");
		_Wave1PosX = 0;
		nameMap.set("Wave 1 Alien To Spawn", "_Wave1AlienToSpawn");
		nameMap.set("Wave 1 Amount", "_Wave1Amount");
		_Wave1Amount = 0;
		nameMap.set("interval", "_interval");
		_interval = 0;
		nameMap.set("lastAlien", "_lastAlien");
		nameMap.set("alienSpeed", "_alienSpeed");
		_alienSpeed = 0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_interval = 0.1;
		_Wave1Num = randomFloatBetween(2, 4);
		for(index0 in 0...Std.int(_Wave1Amount))
		{
			runLater(1000 * (_Wave1Num + _interval), function(timeTask:TimedTask):Void
			{
				_interval = (_interval + .1);
				createRecycledActor(_Wave1AlienToSpawn, _Wave1PosX, _Wave1PosY, Script.FRONT);
				_lastAlien = getLastCreatedActor();
				_lastAlien.setValue("Level 2 Alien Movement", "_speed", _alienSpeed);
				_lastAlien.setValue("Level 2 Alien Movement", "_InitialDirection", 270);
			}, null);
		}
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}