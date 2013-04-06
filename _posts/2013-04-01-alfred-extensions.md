---
layout: blog
published: true

title: Alfred Extensions
excerpt: A selection of Alfred extensions made to aid developers
---

With the release of Alfred v2 powerpack users have more flexibility than ever to create custom worlkflows. I have put together three quick extensions to make my own life easier, although others are more than welcome to take an use, or modify, these for any purpose. 

### Responsive Calucator

<figure>
	<a href="/assets/alfred_extensions/ResponsiveCalculator.alfredworkflow" title="Download the Responsive Calculator workflow for Alfred"><img src="/assets/images/blog/2013-04-01-alfred-externsions/responsiveCalc.png" alt="Responsive Calculator workflow for Alfred" /></a>
	<figcaption>
		Responsive Calculator workflow for Alfred
	</figcaption>
</figure>

The first extension is a responsive calulator. After getting tired of manually doing the maths for every box I was creating when converting a PSD to a web page I decided to make an extension to do this for me. 

The script is triggered using ```rc``` and requires two parameters. The first should be the with of the item you want to calculate the percentage width for and the other should be the width of the container. The default container width is 980px.  

For example, for a 300px wide div in a 900px wide container you would type `rc 300 900` at which point the script would return ```33.33%```.

<a href="/assets/alfred_extensions/ResponsiveCalculator.alfredworkflow" title="Download the Responsive Calculator workflow for Alfred">Download Responsive Calculator</a>

### Search MDN

<figure>
	<a href="/assets/alfred_extensions/SearchMDN.alfredworkflow" title="Download the Responsive Calculator workflow for Alfred"><img src="/assets/images/blog/2013-04-01-alfred-externsions/searchMdn.png" alt="Search MDN workflow for Alfred" /></a>
	<figcaption>
		Search MDN workflow for Alfred
	</figcaption>
</figure>

This second extension is a quick custom search workflow. Simply type ```mdn``` followed by what you want to search the <a href="https://developer.mozilla.org/en-US/" title="Mozilla Developer Network">Mozilla Developer Network</a> for. I primarily use this one for looking up css attributes to see what parameters they can take. 

<a href="/assets/alfred_extensions/SearchMDN.alfredworkflow" title="Download the Search Mozilla Developer Network workflow for Alfred">Download Search MDN</a>

### Search PHP Documentation

<figure>
	<a href="/assets/alfred_extensions/SearchPHPDocumentation.alfredworkflow" title="Download the Search PHP Documentation workflow for Alfred"><img src="/assets/images/blog/2013-04-01-alfred-externsions/searchPHP.png" alt="Search PHP workflow for Alfred" /></a>
	<figcaption>
		Search PHP workflow for Alfred
	</figcaption>
</figure>

Searches the <a href="http://php.net/docs.php" title="PHP Documentation Website">PHP documentation</a> site for any provided input. If the input is a valid function name (e.g. ```str_replace```) it will take you directly to the documentation page for that function. An example search for the ```str_replace()``` function would be ```php str_replace```

<a href="/assets/alfred_extensions/SearchPHPDocumentation.alfredworkflow" title="Download the Search PHP Documentation workflow for Alfred">Download Search PHP Documentation </a>

---

If anyone has any suggestions for more extensions, improvments to my existing ones or finds any bugs please <a href="/contact/" title=-"Contact Daniel Groves">drop me an email</a> or comment below. 