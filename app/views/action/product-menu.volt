<div class="inverted product-header" style="display: none">
    {{ category.name }}
</div>
<div class="inverted content" style="display: none">
    <ul>
        {% for product in products %}
        <li><a href="" class="call" data-value="{{ product.id }}">{{ product.name }}</a></li>
        {% endfor %}
    </ul>
</div>