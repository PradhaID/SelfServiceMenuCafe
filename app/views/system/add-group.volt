<div class="content">
<div class="ui middle aligned equal width stackable grid">
    <div class="equal width row">
        <div class="column">
            <h1 class="ui header">
                <i class="spy icon"></i>
                <div class="content">
                    Add Group
                </div>
            </h1>
        </div>
        <div class="right aligned column">
            <a class="ui small magenta button" href="{{ url('system/group/') }}"><i class="angle left icon"></i> Back</a>
        </div>
    </div>
</div>
<div class="ui divider"></div>
{% if error.group is defined or error.name is defined or error.description is defined or error.save is defined %}
    <div class="ui negative message">
        <i class="close icon"></i>
        <div class="header">
            Oops...! Something is missing like :
        </div>
        <ul>
            {% if error.name is defined %}
                <li>nama masih kosong</li>
            {% endif %}
            {% if error.description is defined %}
                <li>description masih kosong</li>
            {% endif %}
            {% if error.save is defined %}
                {% for save in error.save %}
                    <li>{{ save }}</li>
                {% endfor %}
            {% endif %}
        </ul>
    </div>

{% endif %}
<form class="ui form" method="post" action="{{ url('system/group/add') }}">
    <div class="fields">
        <div class="eight wide field">
            <label>Group Name</label>
            <input type="text" placeholder="Group Name" name="name" value="{% if request.isPost() %}{{ request.get('name') }}{% else %}{% endif %}">
        </div>
    </div>
    <div class="field">
        <label>Group Description</label>
        <textarea name="description" placeholder="Group Description">{% if request.isPost() %}{{ request.get('description') }}{% else %}{% endif %}</textarea>
    </div>
    <div class="field">
        <button type="submit" class="ui magenta button"><i class="save icon"></i> Add</button>
    </div>
</form>
</div>

<script>
    $('.ui.form')
        .form({
            fields:{
                name: {
                    identifier  : 'name',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please enter your name'
                        }
                    ]
                },
                description: {
                    identifier  : 'description',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please enter your description'
                        }
                    ]
                }
            },
            inline: true,
            on: blur,
            transition: 'fade down',


        })
    ;
</script>