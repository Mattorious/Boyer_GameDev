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



class Design_36_36_CheckForSceneEnd extends SceneScript
{
	public var _NumberKilled:Float;
	public var _NumberOfEnemies:Float;
	public var _sceneEnded:Bool;
	public var _NextScene:Scene;
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("NumberKilled", "_NumberKilled");
		_NumberKilled = 0.0;
		nameMap.set("NumberOfEnemies", "_NumberOfEnemies");
		_NumberOfEnemies = 0.0;
		nameMap.set("sceneEnded", "_sceneEnded");
		_sceneEnded = false;
		nameMap.set("NextScene", "_NextScene");
		
	}
	
	override public function init()
	{
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((_NumberKilled >= _NumberOfEnemies))
				{
					if((_sceneEnded == false))
					{
						_sceneEnded = true;
						createRecycledActor(getActorType(42), 0, 0, Script.BACK);
						runLater(1000 * 2, function(timeTask:TimedTask):Void
						{
							switchScene(_NextScene.getID(), null, createCrossfadeTransition(1));
						}, null);
					}
				}
			}
		});
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(_sceneEnded)
				{
					g.setFont(getFont(37));
					g.drawString("" + "Invasion Halted", ((getScreenWidth() / 2) - (getFont(37).font.getTextWidth("Invasion Halted", getFont(37).letterSpacing)/Engine.SCALE / 2)), ((getScreenHeight() / 2) - (getFont(37).getHeight()/Engine.SCALE / 2)));
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}