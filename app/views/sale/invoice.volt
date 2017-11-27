<div class="ui middle aligned equal width stackable grid">
    <div class="equal width row">
        <div class="column">
            <h1 class="ui header">
                <i class="payment icon"></i>
                <div class="content">
                    Invoice
                </div>
            </h1>
        </div>
        <div class="right aligned column">

        </div>
    </div>
</div>
<div class="ui divider"></div>
<div class="ui middle aligned equal width stackable grid">

    <div class="eleven wide column src-result">
        Page {{ page.current }} of {{ page.total_pages }}
    </div>
    <div class="five wide right aligned column">
        <form class="ui form">
            <div class="field">
                <div class="ui icon input">
                    <i class="search icon"></i>
                    <input type="text" name="src" placeholder="Search...">
                </div>
            </div>
        </form>
        <script>
            $(document).ready(function(){
                $('.ui.form').form({
                    fields:{
                        src: {
                            identifier  : 'src',
                            rules: [
                                {
                                    type   : 'empty',
                                    prompt : 'please enter search term'
                                }

                            ]
                        },
                    },
                    inline: true,
                    on: blur,
                    transition: 'fade down',
                    onSuccess : function(event){
                        event.preventDefault();
                        $('#result').html('please wait...');
                        $.ajax({
                            type: "post",
                            url: "{{ url('sale/invoice/src') }}",
                            data: $('.ui.form').find("select, textarea, input").serialize(),
                            success: function(result){
                                $('#result').html(result);

                            }
                        });
                        $.ajax({
                            type: "post",
                            url: "{{ url('sale/invoice/src-result') }}",
                            data: $('.ui.form').find("select, textarea, input").serialize(),
                            success: function(result){
                                $('.src-result').html(result);

                            }
                        });
                    }
                });
            });
        </script>
    </div>

</div>
<div class="ui divider"></div>
<div id="result">
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
    {% for invoice in page.items %}
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

<div class="ui  grid">
    <div class="ui center aligned column">


        <div class="ui pagination small menu">
            <a href="{{ url('sale/invoice/') }}" class="item">
                <i class="angle double left icon"></i>
            </a>
            <a href="{{ url('sale/invoice/') }}{{ page.before }}" class="item">
                <i class="angle left icon"></i>
            </a>
            {% for i in 1..page.last %}
                <a class="item">
                    {{ i }}
                </a>
            {% endfor %}
            <a href="{{ url('sale/invoice/') }}{{ page.next }}" class="item">
                <i class="angle right icon"></i>
            </a>
            <a href="{{ url('sale/invoice/') }}{{ page.last }}" class="item">
                <i class="angle double right icon"></i>
            </a>
        </div>
    </div>
</div>
</div>