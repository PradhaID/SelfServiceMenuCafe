<div class="ui middle aligned equal width stackable grid">
    <div class="equal width row">
        <div class="column">
            <h1 class="ui header">
                <i class="payment icon"></i>
                <div class="content">
                    Invoice #{{ invoice.number }} -&nbsp;&nbsp; <strong class="ui tag {% if invoice.status!=5 %}red{% else %}green{% endif %} label">{{ invoice.status_name }}</strong>
                </div>
            </h1>
        </div>
        <div class="right aligned column">
            <a class="ui small magenta button" href="{{ url('sale/invoice/') }}"><i class="angle left icon"></i> Back</a>
            {% if invoice.status!=5 %}
            <button type="button" class="ui magenta pay button"><i class="money icon"></i> Pay</button>
            <div class="ui pay modal">
                <i class="close icon"></i>
                <div class="header">
                    <i class="payment icon"></i> Pay Invoice
                </div>
                <div class="content">
                    <form id="pay" class="ui form" method="post" action="{{ url('sale/invoice/detail/') }}{{ id }}">
                        <div class="fields">
                            <div class="ten wide field">
                                <label>Customer Name</label>
                                <input type="text" name="name" placeholder="Customer Name" value="{% if request.isPost() %}{{ request.getPost('name') }}{% endif %}">
                            </div>
                            <div class="six wide field">
                                <label>Pay Amount</label>
                                <input type="text" name="amount" placeholder="Pay Amount" value="{% if request.isPost() %}{{ request.getPost('amount') }}{% endif %}">
                            </div>
                        </div>
                        <div class="field">
                            <label>Customer Address</label>
                            <textarea name="address" placeholder="Customer Address">{% if request.isPost() %}{{ request.getPost('address') }}{% endif %}</textarea>
                        </div>
                    </form>
                </div>
                <div class="actions">
                    <button class="ui black deny button">
                        Nope
                    </button>
                    <button type="submit" form="pay" class="ui magenta button">Pay</button>
                </div>
            </div>
            <script>
                $(document).ready(function(){
                    $('.pay.modal').modal('attach events', '.pay.button', 'show');
                    $.fn.form.settings.rules.greaterThan = function (inputValue, validationValue) {
                        return inputValue >= {{ invoice.total }};
                    };
                    $('.ui.form').form({
                        fields: {
                            name: {
                                identifier: 'name',
                                rules: [
                                    {
                                        type: 'empty'
                                    }
                                ]
                            },
                            amount: {
                                identifier: 'amount',
                                rules: [
                                    {
                                        type: 'empty'
                                    },
                                    {
                                        type: 'number'
                                    },
                                    {
                                        type: 'greaterThan[{{ invoice.total }}]',
                                        prompt: 'Amount must be greather than {{ invoice.total }}'
                                    }
                                ]
                            },
                            address: {
                                identifier: 'address',
                                rules: [
                                    {
                                        type: 'empty'
                                    }
                                ]
                            },
                        },
                        inline : true,
                        on     : 'blur'
                    });
                });
            </script>
            {% else %}
            <button type="button" class="ui magenta print button"><i class="print icon"></i> Print</button>
            {% endif %}
        </div>
    </div>
</div>
<div class="ui divider"></div>
{% if status=="success" %}
    <div class="ui positive message">
        <i class="close icon"></i>
        <div class="header">
            <i class="check icon"></i> Success
        </div>
        <p>Payment has been successfully created. Change : <strong>Rp{{ (invoice.pay_amount-invoice.total)|numberFormat }}</strong></p>
    </div>
{% endif %}
<table class="ui mini striped compact selectable table">
    <thead>
    <tr>
        <th>Product Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Qty</th>
        <th>Discount</th>
        <th>Total</th>
    </tr>
    </thead>
    <tbody>
    {% set total=0 %}
    {% for detail in details %}
        <tr>
            <td>{{ detail.product_name }}</td>
            <td>{{ detail.product_description }}</td>
            <td class="right aligned">{{ detail.selling_price|numberFormat }}</td>
            <td class="center aligned">{{ detail.quantity }}</td>
            <td class="right aligned">{{ detail.discount }}%</td>
            <td class="right aligned">{{ detail.total|numberFormat }}</td>
        </tr>
        {% set total=total+detail.total %}
    {% endfor %}
    </tbody>
    <tfoot>
    <tr class="positive">
        <td colspan="5">Sub Total</td>
        <td class="right aligned">{{ total|numberFormat }}</td>
    </tr>
    <tr class="positive">
        <td colspan="5">Discount</td>
        <td class="right aligned">{{ invoice.discount|numberFormat }}</td>
    </tr>
    <tr class="negative">
        <td colspan="5">Tax</td>
        <td class="right aligned">{{ invoice.tax|numberFormat }}</td>
    </tr>
    <tr class="positive">
        <td colspan="5">Total</td>
        <td class="right aligned">{{ invoice.total|numberFormat }}</td>
    </tr>
    </tfoot>
</table>