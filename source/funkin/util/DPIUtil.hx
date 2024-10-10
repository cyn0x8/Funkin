package funkin.util;

import lime.app.Application;
import lime.system.Display;
import lime.system.System;
import lime.ui.Window;
import flixel.FlxG;
import Main;

#if windows
@:cppInclude("windows.h")
@:cppInclude("winuser.h")
#end

/**
 * Utilities for DPI awareness.
 */
class DPIUtil
{
  public static function __init__():Void
  {
    #if windows
    registerDPIAwareness();
    #end
  }

  #if windows
  @:functionCode("SetProcessDPIAware();")
  public static function registerDPIAwareness():Void {}
  #end

  public static var dpiScale(get, never):Float;
  private static function get_dpiScale():Float
  {
    var display:Display = System.getDisplay(0);
    if (display != null)
    {
      return display.dpi / (
        #if windows 96
        #elseif mac 72
        #elseif linux 96
        #elseif ios 163
        #elseif android 160
        #else 96
        #end
      );
    }

    return 1;
  }

  public static function fixWindowSize():Void
  {
    #if desktop // (windows?)
    var window:Window = Application.current.window;
    var prevWidth:Int = window.width;
    var prevHeight:Int = window.height;
    window.width = Std.int(Main.gameWidth * dpiScale);
    window.height = Std.int(Main.gameHeight * dpiScale);
    window.x += Std.int((prevWidth - window.width) / 2);
    window.y += Std.int((prevHeight - window.height) / 2);
    #end
  }
}
