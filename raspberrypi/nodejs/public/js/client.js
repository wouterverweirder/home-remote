(function(){
	FastClick.attach(document.body);
	$('button').on('click', function(){
		$.ajax({
			cache: false,
			url: '/remote/' + $(this).data('remote-name') + '/' + $(this).data('remote-key')}
		);
	});
})();