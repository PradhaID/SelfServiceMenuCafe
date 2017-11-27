{% if session.get('table')!="" %}
    Nomor Meja
    <span class="table-no">
        <button type="button" class="ui magenta select-table mini button">{{ session.get('table') }}</button>
    </span>
    <div class="ui divider"></div>
    {% if session.get('cart')|length>0 %}
    <div>
        <button type="button" class="ui mini magenta pay button">BAYAR</button>
        <button type="button" class="ui mini grey delete-cart button">HAPUS</button>
    </div>
    {% endif %}
{% else %}
    <button type="button" class="ui magenta select-table mini button">Pilih Meja</button>
{% endif %}