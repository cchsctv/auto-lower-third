# easy-title-generator
Script to generate lower thirds with alpha via text input for Adobe After Effects

# Purpose
- To be easy, such that lower thirds via After Affects can be made without any knowledge of After Effects
- To produce consistent, uniform lower thirds

# System Requirements
- Mac OS 10.6.8+
- Adobe After Effects CS6 (Might work in [non-royalty bearing mode](https://blogs.adobe.com/creativecloud/codecs-and-the-render-engine-in-after-effects-cs6/) but not tested)

# TODO
- Allow for instances
- Escape charaters to allow slashes in "Name"
- Make execption when existing name is entered.
- Optimize sequence for better render time
- Detect and use other versions of after effects
- Windows support...

# Notes
Normally editing the contents of text layers is [impossible](https://forums.adobe.com/thread/1190873) via After Effects XML files. What is editable via XML though are layer names. By setting the source text of a text layer to the espression 
<pre><code>s = name</code></pre>

After Effects grabs the layer name and uses it as the source text, allowing the editing of source text via XML.


# License
Execpt for:
- Adobe, the Adobe logo, and After Effects are either registered trademarks or trademarks of Adobe Systems Incorporated in the United States and/or other countries.
- Backing.mov - by Jason Chua, Copyright Cooper City High School 2016

This project is is licensed under the MIT License
