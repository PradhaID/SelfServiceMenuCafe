<div class="ui middle aligned equal width stackable grid">
    <div class="equal width row">
        <div class="column">
            <h1 class="ui header">
                <i class="tag icon"></i>
                <div class="content">
                    Edit Table
                </div>
            </h1>
        </div>
        <div class="right aligned column">
            <a class="ui small magenta button" href="{{ url('content/table/') }}"><i class="angle double left icon"></i> Back</a>
        </div>
    </div>
</div>
<div class="ui divider"></div>
{% if status=="successadd" OR status=="success" %}
    <div class="ui positive message">
        <i class="close icon"></i>
        <div class="header">
            {% if status=="successadd" %}Your request has been succesfuly created{% else %}Your request has been succesfuly updated{% endif %}
        </div>
    </div>
{% endif %}
{% if error.number is defined or error.floor is defined or error.capacity is defined or error.smoke is defined or error.description is defined or error.x is defined or error.y is defined or error.save is defined %}
    <div class="ui negative message">
        <i class="close icon"></i>
        <div class="header">
            Oops...! Something is missing like :
        </div>
        <ul>
            {% if error.number is defined %}
                <li>Number is empty</li>
            {% endif %}
            {% if error.floor is defined %}
                <li>Floor not selected</li>
            {% endif %}
            {% if error.capacity is defined %}
                <li>Capacity not selected</li>
            {% endif %}
            {% if error.smoke is defined %}
                <li>Smoke not selected</li>
            {% endif %}
            {% if error.description is defined %}
                <li>Description is empty</li>
            {% endif %}
            {% if error.x is defined %}
                <li>Position X is invalid</li>
            {% endif %}
            {% if error.y is defined %}
                <li>Position Y is invalid</li>
            {% endif %}
            {% if error.save is defined %}
                {% for save in error.save %}
                    <li>{{ save }}</li>
                {% endfor %}
            {% endif %}
        </ul>
    </div>
{% endif %}
<form class="ui form" method="post" action="{{ url('content/table/edit/') }}{{ id }}">
    <div class="fields">
        <div class="three wide field">
            <label>Table Number (Code)</label>
            <input type="text" name="number" placeholder="Table Number (Code)" value="{% if request.isPost() %}{{ request.getPost('number') }}{% else %}{{ table.id }}{% endif %}">
        </div>
        <div class="two wide field">
            <label>Floor</label>
            <div class="ui selection fluid dropdown">
                <input type="hidden" name="floor" placeholder="Floor Level" value="{% if request.isPost() %}{{ request.getPost('floor') }}{% else %}{{ table.floor }}{% endif %}">
                <i class="dropdown icon"></i>
                <div class="default text">Floor</div>
                <div class="menu">
                    <div class="item" data-value="1">1</div>
                    <div class="item" data-value="2">2</div>
                </div>
            </div>
        </div>
        <div class="three wide field">
            <label>Capacity</label>
            <div class="ui selection fluid dropdown">
                <input type="hidden" name="capacity" placeholder="Table Capacity" value="{% if request.isPost() %}{{ request.getPost('capacity') }}{% else %}{{ table.capacity }}{% endif %}">
                <i class="dropdown icon"></i>
                <div class="default text">Capacity</div>
                <div class="menu">
                    {% for i in 1..20 %}
                        <div class="item" data-value="{{ i }}">{{ i }} Person{% if i!=1 %}s{% endif %}</div>
                    {% endfor %}
                </div>
            </div>
        </div>
        <div class="two wide field">
            <label>Smoke</label>
            <div class="ui selection fluid dropdown">
                <input type="hidden" name="smoke" placeholder="Smoke" value="{% if request.isPost() %}{{ request.getPost('smoke') }}{% else %}{% if table.smoke %}true{% else %}false{% endif %}{% endif %}">
                <i class="dropdown icon"></i>
                <div class="default text">Smoke</div>
                <div class="menu">
                    <div class="item" data-value="true">Yes</div>
                    <div class="item" data-value="false">No</div>
                </div>
            </div>
        </div>
    </div>
    <div class="field">
        <label>Description</label>
        <textarea name="description" placeholder="Table Description">{% if request.isPost() %}{{ request.getPost('description') }}{% else %}{{ table.description }}{% endif %}</textarea>
    </div>
    <div class="fields">
        <div class="two wide field">
            <label>Position</label>
            <input type="text" name="x" placeholder="Position X" value="{% if request.isPost() %}{{ request.getPost('x') }}{% else %}{{ table.position_x }}{% endif %}">
        </div>
        <div class="two wide field">
            <label>&nbsp;</label>
            <input type="text" name="y" placeholder="Position Y" value="{% if request.isPost() %}{{ request.getPost('y') }}{% else %}{{ table.position_y }}{% endif %}">
        </div>
        <div class="two wide field">
            <label>Available</label>
            <div class="ui selection fluid dropdown">
                <input type="hidden" name="available" placeholder="Available" value="{% if request.isPost() %}{{ request.getPost('available') }}{% else %}{% if table.available %}true{% else %}false{% endif %}{% endif %}">
                <i class="dropdown icon"></i>
                <div class="default text">Available</div>
                <div class="menu">
                    <div class="item" data-value="true">Yes</div>
                    <div class="item" data-value="false">No</div>
                </div>
            </div>
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
                number: {
                    identifier  : 'number',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please enter number'
                        }
                    ]
                },
                floor: {
                    identifier  : 'floor',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please selected floor'
                        }
                    ]
                },
                capacity: {
                    identifier  : 'capacity',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please selected capacity'
                        }
                    ]
                },
                smoke: {
                    identifier  : 'smoke',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please selected smoke'
                        }
                    ]
                },
                x: {
                    identifier  : 'x',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please enter position x'
                        }
                    ]
                },
                y: {
                    identifier  : 'y',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please enter position y'
                        }
                    ]
                },
                description: {
                    identifier  : 'description',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please enter description'
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