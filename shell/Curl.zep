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
 * Class Curl.
 */
class Curl {
	private resource;
	private settingsContainer;
	private static instances;

	/**
	 * Constructor.
	 * Checks if curl extension is loaded.
	 */
	public function __construct() {
		if unlikely !extension_loaded("curl") {
			throw new DependencyException("Required extension \"curl\" is not loaded!");
		}
	}

	/**
	 * Destructor.
	 * Frees memory of opened curl resource.
	 */
	public function __destruct() {
		if is_resource(this->resource) {
			curl_close(this->resource);
		}
	}

	/**
	 * Gets a named Curl instance.
	 * @param string name Instance name
	 * @return Curl a Curl instance
	 */
	public static function getInstance(string name = "default") -> <Curl> {
		var instance;
		if fetch instance, self::instances[name] {
			return instance;
		}
		let self::instances[name] = new self();
		return self::instances[name];
	}

	/**
	 * Returns curl raw resource
	 * @return resource Result of curl_init()
	 */
	public function getResource() {
		if is_null(this->resource) {
			let this->resource = curl_init();
		}
		return this->resource;
	}

	/**
	 * Gets content available by passed url.
	 * @param string url Url
	 * @param array config Options for curl_setopt_array()
	 * @return string|boolean Result of curl_exec()
	 */
	public function getUrlContents(string url, array config = []) -> string|boolean {
		var ch;
		let ch = this->getResource();
		curl_setopt(ch, CURLOPT_URL, url);
		curl_setopt(ch, CURLOPT_HEADER, 0);
		curl_setopt(ch, CURLOPT_RETURNTRANSFER, true);

		if !empty(this->settingsContainer) {
			curl_setopt_array(ch, this->settingsContainer->getCurlSettings());
		}
		curl_setopt_array(ch, config);

		var result;
		let result = curl_exec(ch);
		if result === false {
			string error;
			int errno;
			let error = (string)curl_error(ch);
			let errno = (int)curl_errno(ch);
			if errno == CURLE_GOT_NOTHING {
				return this->getUrlContents(url, config);
			} else {
				throw new \RuntimeException("Curl error (".errno.") \"".error."\"");
			}
		}
		return result;
	}

	/**
	 * Sends data with POST method.
	 * @param string url Url
	 * @param array data Post fields.
	 * @param array config Options for curl_setopt_array()
	 * @return string|boolean Result of curl_exec()
	 */
	public function performPostRequest(string url, array data = [], array config = []) -> string|boolean {
		var ch;
		let ch = this->getResource();
		curl_setopt(ch, CURLOPT_URL, url);
		curl_setopt(ch, CURLOPT_HEADER, 0);
		curl_setopt(ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt(ch, CURLOPT_POST, true);
		curl_setopt(ch, CURLOPT_POSTFIELDS, http_build_query(data));

		if !empty(this->settingsContainer) {
			curl_setopt_array(ch, this->settingsContainer->getCurlSettings());
		}
		curl_setopt_array(ch, config);

		var result;
		let result = curl_exec(ch);
		if result === false {
			string error;
			int errno;
			let error = (string)curl_error(ch);
			let errno = (int)curl_errno(ch);
			if errno == CURLE_GOT_NOTHING {
				return this->performPostRequest(url, data, config);
			} else {
				throw new \RuntimeException("Curl error (".errno.") \"".error."\"");
			}
		}
		return result;
	}

	/**
	 * Saves settings container to use it in requests.
	 * @param CurlSettingsContainer container an object that implements interface.
	 * @return Curl this instance
	 */
	public function setSettingsContainer(<CurlSettingsContainer> container) -> <Curl> {
		let this->settingsContainer = container;
		return this;
	}
}
