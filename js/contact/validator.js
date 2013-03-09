$(document).ready(function() {
	init();
});

var name	= '#name';
var email	= '#email';
var subject = '#subject';
var message = '#message';
	
var name_valid 		= false;
var email_valid		= false;
var subject_valid	= false;
var message_valid	= false;

var check = {
	name: function() {
		if ( $(name).val() != '' ) {
			name_valid = true;
			
			$(name).removeClass('invalid').addClass('valid');
		} else {
			name_valid = false;
			
			$(name).removeClass('valid').addClass('invalid');
		}
	},
	email: function() {
		if ( $(email).val() != '' ) {
			email_valid = true;
			
			$(email).removeClass('invalid').addClass('valid');
		} else {
			email_valid = false;
			
			$(email).removeClass('valid').addClass('invalid');
		}
	},
	subject: function() {
		if ( $(subject).val() != '' ) {
			subject_valid = true;
			
			$(subject).removeClass('invalid').addClass('valid');
		} else {
			subject_valid = false;
			
			$(subject).removeClass('valid').addClass('invalid');
		}
	},
	message: function() {
		if ( $(message).val() != '' ) {
			message_valid = true;
			
			$(message).removeClass('invalid').addClass('valid');
		} else {
			message_valid = false;
			
			$(message).removeClass('valid').addClass('invalid');
		}
	},
	all: function() {
		check['name']();
		check['email']();
		check['subject']();
		check['message']();
	}
};

var valid = function() {
	if ( name_valid && email_valid && subject_valid && message_valid )
		return true;
	else 
		return false;
}

var post_data = function() {
	var action = $('form').attr('action') + '?js=true';
	var form = $.post(action, $("form").serialize());
	
	form.done(function() {
		$('form').parent().prepend('<p class="success">Your message has been successfully sent. I will do my best to get back to you with 48-hours, although during busy times it may as long as a week. </p>');
		$('form').fadeOut();
	});
	
	form.fail(function() {
		$('form').parent().prepend('<p class="error">I\'m sorry, their was an unknown error sending the message. If this keeps happening you can contact me by emailing hello[at]danielgroves[dot]net, or using any of the social networks listed in the left. Sorry about that. </p>');
	});
}

var init = function() {
	
	$('input, textarea').bind('focusout', function() {
		check[$(this).attr('name')]();
	});
	
	
	$('form').submit(function(e) {
		e.preventDefault();
		
		if ( valid() )
			post_data();
		else {
			check['all']();
			
			if ( valid() )
				post_data();
		}
	});
}
