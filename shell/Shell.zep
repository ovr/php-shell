/**
 * Shell extension.
 *
 * @author Sergei Vanyushin <wapmorgan@gmail.com>
 * @link https://github.com/wapmorgan/Shell
 * @license Apache License 2.0
 * @license http://www.apache.org/licenses/LICENSE-2.0.html
 */
namespace Shell;

/**
 * Class Shell.
 */
class Shell {
	/**
	 * Script filename being executed.
	 */
	private script = null;
	/**
	 * Passed arguments to script.
	 */
	private arguments = [];
	/**
	 * The number of passed arguments.
	 */
	private argc = 0;
	/**
	 * Registered script handler.
	 */
	private handler = null;
	/**
	 * Registered script options.
	 */
	private options = [];
	/**
	 * Whether to use or not to use colors.
	 */
	public useColors = true;
	/**
	 * InputOutput object.
	 */
	private io = null;

	/**
	 * Available colors.
	 */
	const BLACK = "30";
	const RED = "31"; // failure
	const GREEN = "32"; // success
	const YELLOW = "33"; // warning
	const BLUE = "34"; // note
	const PURPLE = "35";
	const CYAN = "36";
	const WHITE = "37";

	/**
	 * Available font faces.
	 */
	const REGULAR = "0";
	const BOLD = "1";
	const UNDERLINE = "4";

	/**
	 * Registers a callback to handle request.
	 * @param callable callback Handler
	 */
	public function registerHandler(callback) -> void {
		if unlikely !is_callable(callback) {
			throw new \InvalidArgumentException("Value " . callback . " is not a valid callable thing.");
		}
		let this->handler = callback;
	}

	/**
	 * Registeres script options.
	 * @param array options List of options.
	 */
	public function registerOptions(array options) -> void {
		var option;
		for option in options {
			if !is_subclass_of(option, "\\".__NAMESPACE__."\\AbstractOption") {
				throw new \InvalidArgumentException("All options should be children of AbstractOption class");
			}
		}
		let this->options = options;
	}

	/**
	 * Resolves called command and runs associated callback.
	 */
	public function process() -> void {
		if empty(this->handler) {
			throw new ShellException("You should register handler before calling " . __METHOD__);
		}
		let this->arguments = _SERVER["argv"];
		let this->argc = _SERVER["argc"];
		let this->script = array_shift(this->arguments);

		var option, arguments = [];
		var tmpValue = null;
		if !empty(this->options) {
			for option in this->options {
				switch (substr(get_class(option), strlen(__NAMESPACE__."\\"))) {
					case "FlagOption":
					case "SwitchOption":
					case "MultiValueOption":
						let arguments[option->name] = option->resolveValue(this->arguments);
						break;
					case "StringOption":
						let tmpValue = option->resolveValue(this->arguments);
						if tmpValue !== null {
							let arguments[option->name] = tmpValue;
						}
						break;
				}
			}
		}
		call_user_func(this->handler, this, arguments);
	}

	/**
	 * Wraps text with escape sequence to change its color.
	 * This method does not colorize text unless `useColors` property is set to true (default).
	 * @param string text
	 * @param string color Font color.
	 * Available font colors:
	 * - Shell::BLACK
	 * - Shell::RED
	 * - Shell::GREEN
	 * - Shell::YELLOW
	 * - Shell::BLUE
	 * - Shell::PURPLE
	 * - Shell::CYAN
	 * - Shell::WHITE
	 * @param string fontFace Font face.
	 * Available font faces:
	 * - Shell::REGULAR - regular font
	 * - Shell::BOLD - bold font
	 * - Shell::UNDERLINE - underlined font
	 */
	public function colorize(string text, string color, string fontFace = "0") -> string {
		if this->useColors !== true {
			return text;
		}
		return chr(27)."[".fontFace.";".color."m".text.chr(27)."[0m";
	}

	/**
	 * Sets background color for text.
	 * This method does not colorize text unless `useColors` property is set to true (default).
	 * @param string text
	 * @param string color Background color.
	 * Available colors:
	 * - Shell::BLACK
	 * - Shell::RED
	 * - Shell::GREEN
	 * - Shell::YELLOW
	 * - Shell::BLUE
	 * - Shell::PURPLE
	 * - Shell::CYAN
	 * - Shell::WHITE
	 */
	public function background(string text, string color) -> string {
		/**
		 * This is a workaround of fucking type-casting that do not allow add 10 to color identificator;
		 * Equivalent is: (string) ((int)color + 10)
		 */
		if this->useColors !== true {
			return text;
		}
		let color = chr(1 + ord(substr(color, 0, 1))).substr(color, 1);
		return chr(27)."[".color."m".text.chr(27)."[0m";
	}

	/**
	 * Prints options list.
	 * @param int shortAliasColumnWidth Width of short aliases column. Defaults to 4.
	 * @param int longAliasColumnWidth Width of long aliases column. Defaults to 20.
	 */
	public function printOptionsList(int! shortAliasColumnWidth = 4, int! longAliasColumnWidth = 20) -> void {
		var option, optType = null, shortAlias = null, longAlias = null;
		int tmpColumnWidth = 0;
		for option in this->options {

			switch (substr(get_class(option), strlen(__NAMESPACE__."\\"))) {
				case "FlagOption":
					let optType = "flag";
					break;
				case "SwitchOption":
					let optType = "switch";
					break;
				case "StringOption":
					let optType = "string";
					break;
				case "MultiValueOption":
					let optType = "multiValue";
					break;
			}

			// render multiValue option line
			if optType == "multiValue" {
				let tmpColumnWidth = shortAliasColumnWidth + longAliasColumnWidth + 1;
				echo sprintf(" %-".tmpColumnWidth."s", "... ... ...");
			} else {
				if !empty(option->shortAlias) {
					let shortAlias = "-".option->shortAlias;
					switch (optType) {
						case "switch":
						case "string":
							// let shortAlias .= "[v]";
							break;
					}
					echo sprintf(" %-".shortAliasColumnWidth."s", shortAlias);
				} else {
					echo str_repeat(" ", shortAliasColumnWidth + 1);
				}

				if !empty(option->longAlias) {
					let longAlias = "--".option->longAlias;
					switch (optType) {
						case "switch":
						case "string":
							// let longAlias .= "=value";
							break;
					}
					echo sprintf(" %-".longAliasColumnWidth."s", longAlias);
				} else {
					echo str_repeat(" ", longAliasColumnWidth + 1);
				}
			}


			if !empty(option->description) {
				echo "\t".option->description;
			}

			echo PHP_EOL;
		}
	}

	/**
	 * Provides access to InputOutput object.
	 * @return InputOutput an InputOutput instance.
	 */
	public function getIO() -> <InputOutput> {
		if this->io === null {
			let this->io = new InputOutput;
		}
		return this->io;
	}
}
