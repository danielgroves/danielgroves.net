---
layout: blog
published: true
title: jQuery on danielgroves.net
date: 2010-11-13 11:21:53.000000000 +00:00
---
I chose jQuery when developing the JavaScript for danielgroves.net because it the form of JavaScript that I am most familiar with.  Their are thousands of plugins, tutorials and code snippets widely available on the web.  

### What is & Why jQuery?

jQuery is a JavaScript library with the slogan <em>"Write Less, Do More"</em>.  It is an open-source system that aims to make it easier to write less JavaScript and do more with what you have written.  

I chose to use jQuery for this project because it is the form of writing JavaScript that I am most familiar with.  I have written small snippets in the past and work with 3<sup>rd</sup> party plugins on numerous occasions which means it is the ideal platform for me to work from.  

### Form Validation

On danielgroves.net one of the main uses for jQuery is for form validation.  I am using jQuery to validate the contents of the form fields and then display an error message if the form fields are not populated, and the email field does not contain an "@" symbol.  Validating form data is actually relatively simple, as shown below with the jQuery I wrote for validating my form data.  

This first line of jQuery checks to see if the document has finished loading, and then executes the containing jQuery when the HTML document has finished downloading.  The second line will then immediately hide all of the error messages.  The third will then watch in anything with a class "button".  When something with the class of "button" is clicked it will then execute the the contained jQuery.  

{% highlight js %}
$(document).ready(function() {
	
	$(".error").hide();
	
	$(".button").click(function() {
{% endhighlight %}

These next four lines simply select each of the input fields and assign them to a variable to make calling them easier later on.  

{% highlight js %}
		var name = $("input#name");
		var subject = $("input#subject");
		var email = $("input#email");
		var message = $("textarea#message");
{% endhighlight %}

This next stage is actually to validate from of the form data.  The code below starts by looking the see if the contents of the name field is empty.  If it is, it errors otherwise it will continue like normal.  If there is an error then the jQuery will show the correct error to go with the field, and focus on the field for the user.  When their is no error it simply ensures that no errors are showing.  

{% highlight js %}
		if (name.val() == "") {
			$("#nameWrap label.error").show();
			$("#nameWrap").addClass("inputError");
			$(name).focus();
			return false;
		} else {
			$("#nameWrap label.error").hide();
			$("#nameWrap").removeClass("inputError");
		}
{% endhighlight %}

The next snippet does exactly the same as the above, only it hooks onto the subject field instead.  

{% highlight js %}
		if (subject.val() == "") {
			$("#subjectWrap label.error").show();
			$("#subjectWrap").addClass("inputError");
			$(subject).focus();
			return false;
		} else {
			$("#subjectWrap label.error").hide();
			$("#subjectWrap").removeClass("inputError");
		}
{% endhighlight %}

When using <tt>indexOf</tt> in JavaScript it will return the location of the character passed into the function.  When this character does not exist it returns a value of -1.  

With this information I can then write an <tt>if</tt> function to validate my email field.  to do this I have asked for the location, using <tt>indexOf</tt> of the character "@".  The <tt>if</tt> statement will then error out of the location of the character is -1, and will otherwise allow the field to go through as valid.  

{% highlight js %}
		if (email.val().indexOf("@") == -1) {
			$("#emailWrap label.error").show();
			$("#emailWrap").addClass("inputError");
			$(name).focus();
			return false;
		} else {
			$("#emailWrap label.error").hide();
			$("#emailWrap").removeClass("inputError");
		}
{% endhighlight %}

The "message" validation work identically to the "name" and "subject" validation.  

{% highlight js %}
		if (message.val() == "") {
			$("#messageWrap label.error").show();
			$("#messageWrap").addClass("inputError");
			$(name).focus();
			return false;
		} else {
			$("#messageWrap label.error").hide();
			$("#messageWrap").removeClass("inputError");
		}
{% endhighlight %}

This final two lines are simply closing the two functions we opened as the start.  

{% highlight js %}
	});
});
{% endhighlight %}

As you can see from the jQuery above, validating forms is actually relatively simple to do.  jQuery makes it easy to select the right elements on the go and validate their values to check that they comply with the check that i want to make.  