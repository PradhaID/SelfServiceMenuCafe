<div class="ui middle aligned equal width stackable grid">
    <div class="equal width row">
        <div class="column">
            <h1 class="ui header">
                <i class="tag icon"></i>
                <div class="content">
                    Categories
                </div>
            </h1>
        </div>
        <div class="right aligned column">
            <a class="ui small magenta button" href="{{ url('content/category/add') }}">Add</a>
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
                                url: "{{ url('content/category/src') }}",
                                data: $('.ui.form').find("select, textarea, input").serialize(),
                                success: function(result){
                                    $('#result').html(result);

                                }
                            });
                            $.ajax({
                                type: "post",
                                url: "{{ url('content/category/src-result') }}",
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
        <th>Parent</th>
        <th>Name</th>
        <th>Description</th>
        <th>Created</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    {% for category in page.items %}
        <tr>
            <td>{{ category.parent_name }}</td>
            <td>{{ category.name }}</td>
            <td>{{ category.description }}</td>
            <td>{{ category.created_at|dateTimeFormat }}</td>
            <td><a href="{{ url('content/category/edit/') }}{{  category.id }}">Edit</a></td>
        </tr>
    {% endfor %}
    </tbody>
</table>
<div class="ui divider"></div>

<div class="ui  grid">
    <div class="ui center aligned column">


        <div class="ui pagination small menu">
            <a href="{{ url('content/category/') }}" class="item">
                <i class="angle double left icon"></i>
            </a>
            <a href="{{ url('content/category/') }}{{ page.before }}" class="item">
                <i class="angle left icon"></i>
            </a>
            {% for i in 1..page.last %}
            <a class="item">
                {{ i }}
            </a>
            {% endfor %}
            <a href="{{ url('content/category/') }}{{ page.next }}" class="item">
                <i class="angle right icon"></i>
            </a>
            <a href="{{ url('content/category/') }}{{ page.last }}" class="item">
                <i class="angle double right icon"></i>
            </a>
        </div>
    </div>
</div>
</div>