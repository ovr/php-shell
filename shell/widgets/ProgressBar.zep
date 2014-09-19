/**
 * Shell extension.
 *
 * @author Sergei Vanyushin <wapmorgan@gmail.com>
 * @link https://github.com/wapmorgan/Shell
 * @license Apache License 2.0
 * @license http://www.apache.org/licenses/LICENSE-2.0.html
 */
namespace Shell\Widgets;

/**
 * Class ProgressBar.
 */
class ProgressBar {
	private width { set };
	private totalSteps { set };
	private filledChar = "=";
	private unfilledChar = ".";
	private arrow = ">";

	/**
	 * Constructs progress bar
	 */
	public function __construct(int! width, int! totalSteps = 100) {
		let this->width = width;
		let this->totalSteps = totalSteps;
	}

	/**
	 * Sets bar style
	 */
	public function style(string filled = "=", string unfilled = ".", string arrow = ">") -> <ProgressBar> {
		let this->filledChar = filled,
			this->unfilledChar = unfilled,
			this->arrow = arrow;
		return this;
	}

	/**
	 * Changes bar state
	 */
	public function progress(int! step) {
		int filledWidth, unfilledWidth;
		echo "\r";
		if step < this->totalSteps {
			let filledWidth = (this->width - 1) / this->totalSteps * step;
			let unfilledWidth = (this->width - 1) - filledWidth;
			echo str_repeat(this->filledChar, filledWidth).this->arrow.str_repeat(this->unfilledChar, unfilledWidth);
		} elseif step === this->totalSteps {
			echo str_repeat(this->filledChar, this->width)."\n";
		} else {
			echo str_repeat(this->unfilledChar, this->width);
		}
	}
}
