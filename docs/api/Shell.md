# Shell

*Shell*

<dl>
  <dt><tt>useColors</tt></dt>
  <dd>Whether to use or not to use colors.</dd>

  <dt><tt>registerHandler</tt><big>(</big><em>callable callback</em><big>)</big></dt>
  <dd>Registers a callback to handle request.</dt>

  <dt><tt>registerOptions</tt><big>(</big><em>array options</em><big>)</big></dt>
  <dd>Registeres script options.</dd>

  <dt><tt>process</tt><big>()</big></dt>
  <dd>Resolves called command and runs associated callback.</dd>

  <dt><tt>colorize</tt><big>(</big><em>string text, string color, string fontFace = "0"</em><big>)</big></dt>
  <dd>Wraps text with escape sequence to change its color.<br />
  This method does not colorize text unless `useColors` property is set to true (default).</dd>

  <dt><tt>background</tt><big>(</big><em>string text, string color</em><big>)</big></dt>
  <dd>Sets background color for text.<br />
  This method does not colorize text unless <code>useColors</code> property is set to true (default).</dd>

  <dt><tt>printOptionsList</tt><big>(</big><em>shortAliasColumnWidth = 4, longAliasColumnWidth = 20</em><big>)</big></dt>
  <dd>Prints options list.</dd>

  <dt><tt>getIO</tt><big>()</big></dt>
  <dd>Provides access to <a href="InputOutput.md">InputOutput</a> object.</dd>
</dl>
