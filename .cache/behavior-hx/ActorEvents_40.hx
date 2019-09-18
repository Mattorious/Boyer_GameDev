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



class ActorEvents_40 extends ActorScript
{
	public var _LocalMoney:Float;
	public var _triggerHUD:Bool;
	public var _HUDYStart:Float;
	public var _MoneyDifferenceText:String;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("LocalMoney", "_LocalMoney");
		_LocalMoney = 0;
		nameMap.set("triggerHUD", "_triggerHUD");
		_triggerHUD = false;
		nameMap.set("HUD Y Start", "_HUDYStart");
		_HUDYStart = 4;
		nameMap.set("MoneyDifferenceText", "_MoneyDifferenceText");
		_MoneyDifferenceText = "";
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_LocalMoney = (Engine.engine.getGameAttribute("Money") : Float);
		propertyChanged("_LocalMoney", _LocalMoney);
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				g.setFont(getFont(37));
				g.drawString("" + (("$") + (("" + (Engine.engine.getGameAttribute("Money") : Float)))), 15, 2);
				if((_triggerHUD == true))
				{
					g.setFont(getFont(48));
					g.drawString("" + _MoneyDifferenceText, 15, -25);
					_LocalMoney = (Engine.engine.getGameAttribute("Money") : Float);
					propertyChanged("_LocalMoney", _LocalMoney);
				}
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(((Engine.engine.getGameAttribute("Money") : Float) > _LocalMoney))
				{
					_MoneyDifferenceText = ("" + (("+$") + ("" + ((Engine.engine.getGameAttribute("Money") : Float) - _LocalMoney))));
					propertyChanged("_MoneyDifferenceText", _MoneyDifferenceText);
					_triggerHUD = true;
					propertyChanged("_triggerHUD", _triggerHUD);
				}
			}
		});
		
		/* =========================== Boolean ============================ */
		addPropertyChangeListener("_triggerHUD", null, function(property:Dynamic, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && cast(property, Bool) == true)
			{
				runLater(1000 * .5, function(timeTask:TimedTask):Void
				{
					_triggerHUD = false;
					propertyChanged("_triggerHUD", _triggerHUD);
				}, actor);
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}