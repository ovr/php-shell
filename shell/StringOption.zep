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
 * Class StringOption.
 */
class StringOption extends AbstractOption {
	public defaultValue = null;

	public function __construct(string! alias, string! name, defaultValue = null) {
		parent::__construct(alias, name);
		let this->defaultValue = defaultValue;
	}

	public function resolveValue(array cmdlineArguments) {
		var value = null;
		let value = this->defaultValue;
		var argument;
		for argument in cmdlineArguments {
			if substr(argument, 0, 2) == "--" {
				if !empty(this->longAlias) {
					if strncmp(argument, "--".this->longAlias."=", strlen("--".this->longAlias."=")) == 0 {
						let value = substr(argument, strlen("--".this->longAlias."="));
					}
				}
			} else {
				if (substr(argument, 0, 1) == "-") {
					if !empty(this->shortAlias) {
						if strncmp(argument, "-".this->shortAlias." ", strlen("-".this->shortAlias)) == 0 {
							let value = substr(argument, strlen("-".this->shortAlias));
						}
					}
				}
			}
		}
		return value;
	}
}
