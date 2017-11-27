<div class="ui middle aligned equal width stackable grid">
    <div class="equal width row">
        <div class="column">
            <h1 class="ui header">
                <i class="tag icon"></i>
                <div class="content">
                    Tambah Kategori
                </div>
            </h1>
        </div>
        <div class="right aligned column">
            <a class="ui small button" href="{{ url('content/category') }}"><i class="chevron left icon"></i> back to lists</a>
        </div>
    </div>
</div>
<div class="ui divider"></div>
{% if error.name is defined or error.description is defined or error.save is defined %}
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
<form class="ui form" method="post" action="{{ url('content/category/add') }}">
    <div class="fields">
        <div class="eight wide field">
            <label>Category Name</label>
            <input type="text" name="name" placeholder="Category Name" value="{% if request.isPost() %}{{ request.getPost('name') }}{% else %}{% endif %}">
        </div>
        <div class="eight wide field">
            <label>Parent</label>
            <div class="ui selection dropdown">
                <input type="hidden" name="parent" placeholder="Category Parent" value="{% if request.isPost() %}{{ request.getPost('parent') }}{% else %}{% endif %}">
                <i class="dropdown icon"></i>
                <div class="default text">parent</div>
                <div class="menu">
                    <div class="item" data-value="">-= no parent =-</div>
                    {% for category in categories %}
                        <div class="item" data-value="{{ category.id }}">{{ category.name }}</div>
                    {% endfor %}
                </div>
            </div>
        </div>
    </div>
    <div class="field">
        <label>Description</label>
        <textarea name="description" placeholder="Category Description">{% if request.isPost() %}{{ request.getPost('description') }}{% else %}{% endif %}</textarea>
    </div>
    <div class="field">
        <button type="submit" class="ui magenta button"><i class="save icon"></i> Save</button>
    </div>

</form>

<script>
    $('.ui.dropdown')
        .dropdown()
    ;
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

