package xa3;

enum Parameter {
	Clear;
	PlaceCursor( x:Int, y:Int );
	ResetFormat;
	Color( c:Color );
	Background( c:Color );
}

enum Color {
	Black;
	Red;
	Green;
	Yellow;
	Blue;
	Magenta;
	Cyan;
	White;
	BrightBlack;
	BrightRed;
	BrightGreen;
	BrightYellow;
	BrightBlue;
	BrightMagenta;
	BrightCyan;
	BrightWhite;
	RGB( r:Int, g:Int, b:Int );
}

typedef Cell = {
	var s:String;
	var color:Color;
	var background:Color;
}

class Ansix {
	
	public static final clear = '\u001b[2J';
	public static final resetFormat = '\u001b[0m';
	public static final resetCursor = '\u001b[1;1H';


	public static function format( s:String, parameters:Array<Parameter> ) {
		
		final sequences = parameters.map( parameter -> {
			switch parameter {
				case Clear: return clear;
				case PlaceCursor(x, y): return '\u001b[${y};${x}H';
				case ResetFormat: return resetFormat;
				case Color(c):
					switch c {
						case RGB( r, g, b ): return '\u001b[38${r};${g}${b}m';
						default:
							final color = getColor( c );
							return '\u001b[${color}m';
					}
				case Background(c):
					switch c {
						case RGB( r, g, b ): return '\u001b[48${r};${g}${b}m';
						default:
							final color = getBackground( c );
							return '\u001b[${color}m';
					}
			}
		});
		return sequences.join("") + s;
	}

	static function getColor( c:Color ) {
		return switch c {
			case Black: 30;
			case Red: 31;
			case Green: 32;
			case Yellow: 33;
			case Blue: 34;
			case Magenta: 35;
			case Cyan: 36;
			case White: 37;
			case BrightBlack: 90;
			case BrightRed: 91;
			case BrightGreen: 92;
			case BrightYellow: 93;
			case BrightBlue: 94;
			case BrightMagenta: 95;
			case BrightCyan: 96;
			case BrightWhite: 97;
			case RGB(r, g, b): throw "Error: in getForegroundColor: RGB should be a separate case";
		}
	}

	static function getBackground( c:Color ) {
		return switch c {
			case Black: 40;
			case Red: 41;
			case Green: 42;
			case Yellow: 43;
			case Blue: 44;
			case Magenta: 45;
			case Cyan: 46;
			case White: 47;
			case BrightBlack: 100;
			case BrightRed: 101;
			case BrightGreen: 102;
			case BrightYellow: 103;
			case BrightBlue:1094;
			case BrightMagenta: 105;
			case BrightCyan: 106;
			case BrightWhite: 107;
			case RGB(r, g, b): throw "Error: in getBackgroundColor: RGB should be a separate case";
		}
	}

}