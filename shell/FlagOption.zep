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
 * Class FlagOption.
 */
class FlagOption extends AbstractOption {
	public defaultState = false;

	public function __construct(string! alias, string! name, boolean! defaultState = false) {
		parent::__construct(alias, name);
		let this->defaultState = defaultState;
	}

	public function resolveValue(array cmdlineArguments) -> boolean {
		boolean value;
		let value = (boolean)this->defaultState;
		var argument;
		for argument in cmdlineArguments {
			if substr(argument, 0, 2) == "--" {
				if !empty(this->longAlias) {
					if argument == "--".this->longAlias {
						let value = true;
					} else {
						if argument == "--no-".this->longAlias {
							let value = false;
						}
					}
				}
			} else {
				if (substr(argument, 0, 1) == "-") {
					if !empty(this->shortAlias) {
						if argument == "-".this->shortAlias {
							let value = true;
						}
					}
				}
			}
		}
		return value;
	}
}
