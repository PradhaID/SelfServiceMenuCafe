<table class="ui mini magenta striped selectable table">
    <thead>
    <tr>
        <th>Invoice No</th>
        <th>Table Number</th>
        <th>Tax</th>
        <th>Discount</th>
        <th>Total</th>
        <th>status</th>
        <th>Created</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    {% for invoice in invoices %}
        <tr class="{% if invoice.status==5 %}positive{% else %}negative{% endif %}">
            <td>{{ invoice.number }}</td>
            <td>{{ invoice.table_number }}</td>
            <td class="right aligned">{{ invoice.tax }}%</td>
            <td class="right aligned">{{ invoice.discount }}%</td>
            <td class="right aligned">{{ invoice.total|numberFormat }}</td>
            <td>{{ invoice.status_name }}</td>
            <td>{{ invoice.created_at|dateTimeFormat }}</td>
            <td><a href="{{ url('sale/invoice/detail/') }}{{  invoice.id }}">Detail</a></td>
        </tr>
    {% endfor %}
    </tbody>
</table>
<div class="ui divider"></div>