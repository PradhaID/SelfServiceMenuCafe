<table class="ui mini magenta striped selectable table">
    <thead>
    <tr>
        <th>Category</th>
        <th>Name</th>
        <th>Description</th>
        <th>Capital Price</th>
        <th>Selling Price</th>
        <th>Created</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    {% for product in products %}
        <tr>
            <td>{{ product.category_name }}</td>
            <td>{{ product.name }}</td>
            <td>{{ product.description }}</td>
            <td>Rp. {{ product.capital_price|numberFormat }}</td>
            <td>Rp. {{ product.selling_price|numberFormat }}</td>
            <td>{{ product.created_at|dateTimeFormat }}</td>
            <td>
                <a href="{{ url('content/product/edit/') }}{{  product.id }}">Edit</a>
                <a href="{{ url('content/product/detail/') }}{{  product.id }}">Detail</a>
            </td>
        </tr>
    {% endfor %}
    </tbody>
</table>
<div class="ui divider"></div>
