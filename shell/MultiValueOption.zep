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
 * Class MultiValueOption.
 */
class MultiValueOption extends AbstractOption {
	public function resolveValue(array cmdlineArguments) -> array {
		var values = [];
		var argument;
		for argument in cmdlineArguments {
			if substr(argument, 0, 2) != "--" && substr(argument, 0, 1) != "-" {
				let values[] = argument;
			}
		}
		return values;
	}
}
