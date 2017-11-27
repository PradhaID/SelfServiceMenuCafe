
<div class="inverted front-menu" style="display: none">
    {{ parent.name }}
</div>
<ul style="display: none">
    {% for category in categories %}
        <li><a class="call" href="#" data-value="{{ category.id }}">{{ category.name }}</a></li>
    {% endfor %}
</ul>
<script>

</script>
