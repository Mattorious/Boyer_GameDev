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



class SceneEvents_7 extends SceneScript
{
	public var _Line1:Bool;
	public var _Line2:Bool;
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("Line 1", "_Line1");
		_Line1 = false;
		nameMap.set("Line 2", "_Line2");
		_Line2 = false;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		stopSoundOnChannel(0);
		runLater(1000 * 2, function(timeTask:TimedTask):Void
		{
			_Line1 = true;
			playSound(getSound(79));
		}, null);
		runLater(1000 * 4, function(timeTask:TimedTask):Void
		{
			_Line2 = true;
			playSound(getSound(79));
		}, null);
		runLater(1000 * 6, function(timeTask:TimedTask):Void
		{
			playSoundOnChannel(getSound(80), 0);
			setVolumeForChannel(50/100, 0);
			switchScene(GameModel.get().scenes.get(1).getID(), createFadeOut(1, Utils.getColorRGB(0,0,0)), createFadeIn(1, Utils.getColorRGB(0,0,0)));
		}, null);
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(_Line1)
				{
					g.setFont(getFont(37));
					g.drawString("" + "Your service is required.", ((getScreenWidth() / 2) - (getFont(37).font.getTextWidth("Your service is required.", getFont(37).letterSpacing)/Engine.SCALE / 2)), (((getScreenHeight() / 2) - (getFont(37).getHeight()/Engine.SCALE / 2)) - 40));
				}
				if(_Line2)
				{
					g.setFont(getFont(37));
					g.drawString("" + "Man the orbital defenses.", ((getScreenWidth() / 2) - (getFont(37).font.getTextWidth("Man the orbital defenses.", getFont(37).letterSpacing)/Engine.SCALE / 2)), (((getScreenHeight() / 2) - (getFont(37).getHeight()/Engine.SCALE / 2)) - 0));
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}