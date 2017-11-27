<div class="ui middle aligned equal width stackable grid">
    <div class="equal width row">
        <div class="column">
            <h1 class="ui header">
                <i class="cubes icon"></i>
                <div class="content">
                    Product
                </div>
            </h1>
        </div>
        <div class="right aligned column">
            <a class="ui small magenta button" href="{{ url('content/product/add') }}">Add</a>

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
                            url: "{{ url('content/product/src') }}",
                            data: $('.ui.form').find("select, textarea, input").serialize(),
                            success: function(result){
                                $('#result').html(result);

                            }
                        });
                        $.ajax({
                            type: "post",
                            url: "{{ url('content/product/src-result') }}",
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
        {% for product in page.items %}
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

    <div class="ui  grid">
        <div class="ui center aligned column">


            <div class="ui pagination small menu">
                <a href="{{ url('content/product/') }}" class="item">
                    <i class="angle double left icon"></i>
                </a>
                <a href="{{ url('content/product/') }}{{ page.before }}" class="item">
                    <i class="angle left icon"></i>
                </a>
                {% for i in 1..page.last %}
                    <a class="item">
                        {{ i }}
                    </a>
                {% endfor %}
                <a href="{{ url('content/product/') }}{{ page.next }}" class="item">
                    <i class="angle right icon"></i>
                </a>
                <a href="{{ url('content/product/') }}{{ page.last }}" class="item">
                    <i class="angle double right icon"></i>
                </a>
            </div>
        </div>
    </div>

</div>


