//closes hamburger menu when document is clicked
$(document).on('click',function(){
	$('.navbar-collapse').collapse('hide');
});
$( '#modal-container' ).modal( {
    focus: false
} );
//closes dropdown menus when document is clicked
$(document).ready(function () {
    $('.dropdown-toggle').dropdown();
});