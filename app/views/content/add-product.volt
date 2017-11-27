<div class="ui middle aligned equal width stackable grid">
    <div class="equal width row">
        <div class="column">
            <h1 class="ui header">
                <i class="cubes icon"></i>
                <div class="content">
                    Tambah Product
                </div>
            </h1>
        </div>
        <div class="right aligned column">
            <a class="ui small button" href="{{ url('content/product') }}"><i class="chevron left icon"></i> back to lists</a>
        </div>
    </div>
</div>
<div class="ui divider"></div>
{% if error.name is defined or error.description is defined or error.category is defined or error.capital_price is defined or error.selling_price is defined or error.save is defined %}
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
            {% if error.category is defined %}
                <li>category masih kosong</li>
            {% endif %}
            {% if error.capital_price is defined %}
                <li>capital price masih kosong</li>
            {% endif %}
            {% if error.selling_price is defined %}
                <li>selling price masih kosong</li>
            {% endif %}
            {% if error.save is defined %}
                {% for save in error.save %}
                    <li>{{ save }}</li>
                {% endfor %}
            {% endif %}
        </ul>
    </div>

{% endif %}
<form class="ui form" method="post" action="{{ url('content/product/add') }}">
    <div class="fields">
        <div class="eight wide field">
            <label>Product Name</label>
            <input type="text" name="name" placeholder="Product Name" value="{% if request.isPost() %}{{ request.getPost('name') }}{% else %}{% endif %}">
        </div>
        <div class="eight wide field">
            <label>Category</label>
            <div class="ui selection dropdown">
                <input type="hidden" name="category" placeholder="Category" value="{% if request.isPost() %}{{ request.getPost('category') }}{% else %}{% endif %}">
                <i class="dropdown icon"></i>
                <div class="default text">category</div>
                <div class="menu">
                    {% for category in categories %}
                        <div class="header" data-value="{{ category.id }}">{{ category.name }}</div>
                        <?php
                                subCategory($category->id, 'item');
                        ?>
                    {% endfor %}
                </div>
            </div>
        </div>
    </div>
        <div class="field">
            <label>Description</label>
            <textarea name="description" placeholder="Category Description">{% if request.isPost() %}{{ request.getPost('description') }}{% else %}{% endif %}</textarea>
        </div>
        <div class="fields">
            <div class="three wide field">
                <label>Capital Price</label>
                <input type="text" name="capital_price" placeholder="Capital Price" value="{% if request.isPost() %}{{ request.getPost('capital_price') }}{% else %}{% endif %}">
            </div>
            <div class="three wide field">
                <label>Selling Price</label>
                <input type="text" name="selling_price" placeholder="Selling Price" value="{% if request.isPost() %}{{ request.getPost('selling_price') }}{% else %}{% endif %}">
            </div>
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

