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
 * Class Formatter.
 */
class Formatter {
	public width = 80;

	/**
	 * Wraps text with given width.
	 */
	public function wrapText(string! text) {
		var chunks; let chunks = str_split(text, this->width);
		var chunk;

		for chunk in chunks {
			echo trim(chunk).PHP_EOL;
		}
	}

	/**
	 * Draws a horizontal line.
	 */
	public function border(string! chars) {
		echo str_repeat(chars, this->width)."\n";
	}

	/**
	 * Progress bar
	 */
	public function progress(int! totalSteps = 100) -> <Widgets\ProgressBar> {
		return new Widgets\ProgressBar(this->width, totalSteps);
	}
}
