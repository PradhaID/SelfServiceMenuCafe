<div class="inverted title">{{ product.name }}</div>
<div class="img">
    <img class="ui fluid image" src="http://www.alaresto.com/wp-content/uploads/2016/09/cara-membuat-roti-bakar-1.jpg">
</div>
<p class="description">{{ product.description }}</p>
<div class="price">Rp. {{ product.selling_price|numberFormat }}</div>
<div>
    <button type="button" class="ui mini magenta add button" data-value="{{ product.id }}">BELI</button>
    <button type="button" class="ui mini grey cancel button">CANCEL</button>
</div>