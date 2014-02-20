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
 * Class SwitchOption.
 */
class SwitchOption extends AbstractOption {
	public cases = [];
	public defaultCase = null;

	public function __construct(string! alias, string! name, array cases, defaultCase = null) {
		parent::__construct(alias, name);
		let this->cases = cases;
		let this->defaultCase = defaultCase;
	}

	public function resolveValue(array cmdlineArguments) {
		var value = null, tmpValue = null;;
		if !empty(this->defaultCase) {
			let value = this->defaultCase;
		}
		var argument;
		for argument in cmdlineArguments {
			if substr(argument, 0, 2) == "--" {
				if !empty(this->longAlias) {
					if strncmp(argument, "--".this->longAlias."=", strlen("--".this->longAlias."=")) == 0 {
						let tmpValue = substr(argument, strlen("--".this->longAlias."="));
						if in_array(tmpValue, this->cases, true) {
							let value = tmpValue;
						}
					}
				}
			} else {
				if (substr(argument, 0, 1) == "-") {
					if !empty(this->shortAlias) {
						if strncmp(argument, "-".this->shortAlias." ", strlen("-".this->shortAlias)) == 0 {
							let tmpValue = substr(argument, strlen("-".this->shortAlias));
							if in_array(tmpValue, this->cases) {
								let value = tmpValue;
							}
						}
					}
				}
			}
		}
		return value;
	}
}
