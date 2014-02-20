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
 * Class AbstractOption.
 */
abstract class AbstractOption {
	public shortAlias = null;
	public longAlias = null;
	public name;
	public description = null;

	public function __construct(string! alias, string! name) {
		if strpos(alias, ":") !== false {
			/**
			 * this is a workaround because <list> statement is not supported at the moment
			 * @see https://github.com/phalcon/zephir/issues/105?source=cc
			 */
			// list(this->shortAlias, this->longAlias) = explode(":", alias);
			var aliasParts;
			let aliasParts = explode(":", alias);
			let this->shortAlias = aliasParts[0];
			let this->longAlias = aliasParts[1];
		} else {
			if strlen(alias) == 1 {
				let this->shortAlias = alias;
			} else {
				let this->longAlias = alias;
			}
		}
		let this->name = name;
	}

	public function resolveValue(array cmdlineArguments) {
		throw new NotImplementedException("Method ".__METHOD__." should be redefined in child class");
	}

	public function setDescription(string description) -> <AbstractOption> {
		let this->description = description;
		return this;
	}
}
