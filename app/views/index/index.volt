<div class="cafe">
	<div class="cafe inverted header">
		<div class="left-header">
			<div class="tv-menu">
				TV Menu
			</div>
			<div class="small left-sub-title">Silahkan Pilih Menu Disini:</div>
		</div>
		<div class="center-header">
			<div class="logo">
			</div>
		</div>
		<div class="right-header">
			<div class="title">Self Service Menu</div>
			<div class="sub-title yellow">Touch Screen System</div>
			<div class="small sub-title">
				Mintalah Bantuan Customer Service Jika Diperlukan
			</div>
		</div>
	</div>
	<div class="navbar">
		<div class="nav-menu">
			<ul>
				{% for menu in menu %}
				<li><a class="call front-menu" href="#" data-value="{{ menu.id }}">{{ menu.name }}</a></li>
				{% endfor %}
			</ul>
		</div>
	</div>

	<div class="border">
	</div>
	<div class="front-container">
		<div class="inverted left-content">
			<div class="ui inverted dimmer">
				<div class="ui medium text loader">Loading</div>
			</div>
			<div class="sub-category list-menu">
				<div class="inverted front-menu">
					Choose Menu
				</div>
				<ul>
					<li style="text-align: center"><br><br>Waiting Customer<br><br></li>
				</ul>
			</div>
			<div class="list-bottom-menu"></div>
		</div>
		<div class="center-content" style="background-image: url({{ url('/img/wood.jpg') }});">
			<div class="product">
				<div class="inverted product-header">
					Nasi Goreng
				</div>
				<div class="inverted content">
					<ul>
						<li><a href="">Roti Bakar Cokelat</a></li>
						<li><a href="">Roti Bakar Keju</a></li>
						<li><a href="">Roti Bakar Cokelat Keju</a></li>
						<li><a href="">Roti Bakar Cokelat Kacang Keju</a></li>
						<li><a href="">Roti Bakar Ice Cream</a></li>
						<li><a href="">Roti Bakar Diruan</a></li>
						<li><a href="">Roti Bakar Kornet Telur</a></li>
						<li><a href="">Roti Bakar Ovomaltine Keju</a></li>
						<li><a href="">Roti Bakar Nutela Keju</a></li>
					</ul>
				</div>
			</div>
			<div class="product-detail">
				<div class="inverted title">Roti Bakar Cokelat Keju</div>
				<div class="img">
					<img class="ui fluid image" src="http://www.alaresto.com/wp-content/uploads/2016/09/cara-membuat-roti-bakar-1.jpg">
				</div>
				<div class="price">Rp. 15.000,-</div>
				<div>
					<button type="button" class="ui mini magenta button">OK</button>
					<button type="button" class="ui mini grey button">CANCEL</button>
				</div>
			</div>
			<div class="cart">
				<div class="inverted title">
					MENU YANG DIPESAN :
				</div>
				<table class="ui small compact table cart-list">
				</table>

				<div class="table-menu">
					{% if session.get('table')!="" %}
						Nomor Meja <span class="table-no">{{ session.get('table') }}</span>
					{% else %}
						<button type="button" class="ui magenta select-table mini button">Pilih Meja</button>
					{% endif %}
				</div>
			</div>
		</div>
		<div class="inverted right-content">
			<div class="list-menu">
				<div class="right-menu">
					<img class="ui centered fluid image" src="{{ url('img/sultan.png') }}">
				</div>
				<div class="right-bottom-menu">Fasilitas :</div>


				<ul>
					<li><a href="">Coffee Shop</a></li>
					<li><a href="">Karaoke</a></li>
					<li><a href="">Live Music</a></li>
					<li><a href="">Event</a></li>
					<li><a href="">Barbershop</a></li>
				</ul>
			</div>
			<div class="list-bottom-menu"></div>
		</div>
	</div>

	<div class="inverted footer">Terima Kasih Atas Kunjungannya
	</div>
</div>
<div class="ui select-table modal">
	<div class="header">
		Select Table
	</div>
	<div class="content">
		<div class="ui form">
			<div class="fields">
				<div class="four wide field">
					<label>Floor</label>
					<div class="ui selection fluid dropdown">
						<input type="hidden" name="floor" placeholder="Floor Level" value="{% if request.isPost() %}{{ request.getPost('floor') }}{% else %}1{% endif %}">
						<i class="dropdown icon"></i>
						<div class="default text">Floor</div>
						<div class="menu">
							<div class="item" data-value="1">1</div>
							<div class="item" data-value="2">2</div>
						</div>
					</div>
				</div>
				<div class="four wide field">
					<label>Capacity</label>
					<div class="ui selection fluid dropdown">
						<input type="hidden" name="capacity" placeholder="Table Capacity" value="{% if request.isPost() %}{{ request.getPost('capacity') }}{% else %}{% endif %}">
						<i class="dropdown icon"></i>
						<div class="default text">Capacity</div>
						<div class="menu">
							{% for i in 1..20 %}
								<div class="item" data-value="{{ i }}">{{ i }} Person{% if i!=1 %}s{% endif %}</div>
							{% endfor %}
						</div>
					</div>
				</div>
				<div class="four wide field">
					<label>Smoke</label>
					<div class="ui selection fluid dropdown">
						<input type="hidden" name="smoke" placeholder="Smoke" value="{% if request.isPost() %}{{ request.getPost('smoke') }}{% else %}{% endif %}">
						<i class="dropdown icon"></i>
						<div class="default text">Smoke</div>
						<div class="menu">
							<div class="item" data-value="true">Yes</div>
							<div class="item" data-value="false">No</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="ui divider"></div>
		<div class="table-selector">

		</div>
	</div>
</div>
<script type="text/javascript">
	function openPrintDialogue(content){
		$('<iframe>', {
			name: 'myiframe',
			class: 'printFrame'
		}).appendTo('body').contents().find('body').append(content);

		window.frames['myiframe'].focus();
		window.frames['myiframe'].print();
		window.frames['myiframe'].close();
		$('iframe').remove();
		window.frames['myiframe'].remove();

		/*setTimeout($(".printFrame").remove(), 1000);*/
	};
	function numberFormat(num){
		var value=parseFloat(num).toFixed(0);
		return value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")
	}
	function getCart(){
		$('.cart-list').html('');
		$.getJSON( "{{ url('action/cart/get') }}", function( data ) {
			var items = [];
			var total = 0;
			$.each( data, function( key, val ) {
				items.push('<tr><td class="center aligned"><i key="'+val.product+'" class="trash icon"></i></td><td>'+val.qty+'x '+val.name+'</td><td class="right aligned" style="text-align: right">'+numberFormat(val.total)+'</td></tr>');
				total=total+val.total;
			});
			items.push('<tr><td colspan="2"><strong>PPN</strong></td><td class="right aligned" style="text-align: right"><strong>'+numberFormat(0)+'</strong></td></tr>');
			items.push('<tr><td colspan="2"><strong>Total</strong></td><td class="right aligned" style="text-align: right"><strong>'+numberFormat(total)+'</strong></td></tr>');
			$('.cart-list').append(items.join());

			$('.total').html('Rp '+numberFormat(total));
			$('.cart-list').fadeIn();
		});
	}
	function getTable() {
		$.ajax({
			type: "post",
			url: "{{ url('action/table/selector') }}",
			data: { floor: $('[name="floor"]').val(), capacity: $('[name="capacity"]').val(), smoke: $('[name="smoke"]').val()},
			success: function(result){
				$('.table-selector').html(result);
			}
		});
	}
	function getTableMenu(){
		$.ajax({
			type: "post",
			url: "{{ url('action/table/menu') }}",
			success: function(result){
				$('.table-menu').html(result);
			}
		});
	}
	$(document).ready(function () {

		$('.ui.dropdown').dropdown();
		$('.select-table.modal').modal({
			onHide: function () {
				$.ajax({
					type: "post",
					url: "{{ url('action/table/menu') }}",
					success: function(result){
						$('.table-menu').html(result);
					}
				});
				console.log('hidden');
			}
		}).modal('attach events', '.select-table.button', 'show');
		getCart();
		getTableMenu();
		$(".product-detail").on('click', '.cancel.button', function(){
			$(".product-detail").fadeOut('fast');
		});
		$(".product-detail").on('click', '.add.button', function(){
			$('.cart-list').fadeOut();
			$('.cart-list').hide();
			var elem=$(this);
			$.ajax({
				type: "post",
				url: "{{ url('action/cart/add') }}",
				data: { id: elem.attr("data-value")},
				success: function(result){
					getCart();
				}
			});
		});

		$(".nav-menu ul li a.call").click(function(event) {
			event.preventDefault();
			$(".sub-category.list-menu").children().slideUp()
					.animate(
							{ opacity: 0 },
							{ queue: false, duration: 'slow' }
					);
			$(".product-detail").fadeOut('fast');
			$(".product").fadeOut('fast');
			var elem=$(this);
			$.ajax({
				type: "post",
				url: "{{ url('action/subCategory') }}",
				data: { id: elem.attr("data-value")},
				success: function(result){
					setTimeout(function() {
						$(".sub-category.list-menu").html(result);
						$(".sub-category.list-menu").children().slideDown()
								.animate(
										{ opacity: 1 },
										{ queue: false, duration: 'slow' }
								);
					}, 350);
				}
			});
			$(".nav-menu ul li a.call").removeClass("active");
			$(this).addClass( "active" );
		});

		$(".sub-category").on('click','.call',function(event) {
			event.preventDefault();
			var elem=$(this);
			$(".product").children().slideUp()
					.animate(
							{ opacity: 0 },
							{ queue: false, duration: 'slow' }
					);
			$(".product-detail").fadeOut('fast');
			$.ajax({
				type: "post",
				url: "{{ url('action/product') }}",
				data: { id: elem.attr("data-value")},
				success: function(result){
					setTimeout(function() {
						$(".product").html(result);
						$(".product").fadeIn('fast');
						$(".product").children().slideDown()
								.animate(
										{ opacity: 1 },
										{ queue: false, duration: 'slow' }
								);
					}, 350);
				}
			});
			$(".sub-category ul li a.call").removeClass("active");
			$(this).addClass( "active" );
		});

		$(".product").on('click','.call',function(event) {
			event.preventDefault();
			var elem=$(this);
			$(".product-detail").fadeOut();
			$.ajax({
				type: "post",
				url: "{{ url('action/productDetail') }}",
				data: { id: elem.attr("data-value")},
				success: function(result){
					setTimeout(function() {
						$(".product-detail").html(result);
						$(".product-detail").fadeIn();
						$(".product-detail").children().fadeIn();
					}, 350);
				}
			});
			$(".product ul li a.call").removeClass("active");
			$(this).addClass( "active" );
		});

		$('.cart').on('click','.trash',function(){
			var value=$(this).attr('key');
			$.confirm({
				icon: 'warning icon',
				title: 'Confirmation',
				content: 'Are you sure?',
				boxWidth: '500px',
				closeIcon: true,
				type: 'dark',
				theme: 'modern',
				typeAnimated: true,
				buttons: {
					confirm: function () {
						$.ajax({
							type: "post",
							url: "{{ url('action/cart/remove') }}",
							data: {id: value},
							success: function(result){
								getCart();
							}
						});
					},
					cancel: function () {
					}
				}
			});

		});

		$('.cart').on('click','.delete-cart',function(){
			$.confirm({
				icon: 'warning icon',
				title: 'Confirmation',
				content: 'Are you sure?',
				boxWidth: '500px',
				closeIcon: true,
				type: 'dark',
				theme: 'modern',
				typeAnimated: true,
				buttons: {
					confirm: function () {
						$.ajax({
							type: "post",
							url: "{{ url('action/cart/erase') }}",
							success: function(result){
								getCart();
								getTableMenu();
							}
						});
					},
					cancel: function () {
					}
				}
			});

		});

		$('.cart').on('click','.pay',function(){
			$.confirm({
				icon: 'warning icon',
				title: 'Confirmation',
				content: 'Are you sure?',
				boxWidth: '500px',
				closeIcon: true,
				type: 'dark',
				theme: 'modern',
				typeAnimated: true,
				buttons: {
					confirm: function () {
						$.ajax({
							type: "post",
							url: "{{ url('action/cart/pay') }}",
							success: function(result){

								getCart();
								getTableMenu();
								openPrintDialogue(result);
							}
						});
					},
					cancel: function () {
					}
				}
			});

		});

		$(".table-menu").on('click', '.select-table.button', function(){
			$('.select-table.modal').modal('show');
			var elem=$(this);
			$.ajax({
				type: "post",
				url: "{{ url('action/table/selector') }}",
				data: { floor: $('[name="floor"]').val(), capacity: $('[name="capacity"]').val(), smoke: $('[name="smoke"]').val()},
				success: function(result){
					$('.table-selector').html(result);
				}
			});
		});
		$('[name="floor"]').on('change',function(){
			getTable();
		});
		$('[name="capacity"]').on('change',function(){
			getTable();
		});
		$('[name="smoke"]').on('change',function(){
			getTable();
		});


		/*$('body').bind('cut copy paste', function (e) {
			e.preventDefault();
		});
		$("body").on("contextmenu",function(e){
			return false;
		});*/
	});
</script>
