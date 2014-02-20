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
 * Interface CurlSettingsContainer.
 */
interface CurlSettingsContainer {
	/**
	 * Should return an array with options for curl_setopt_array().
	 */
	public function getCurlSettings() -> array;
}
