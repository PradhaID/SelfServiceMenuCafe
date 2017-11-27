<div class="ui middle aligned equal width stackable grid">
    <div class="equal width row">
        <div class="column">
            <h1 class="ui header">
                <i class="spy icon"></i>
                <div class="content">
                    Edit User
                </div>
            </h1>
        </div>
        <div class="right aligned column">
            <a class="ui small magenta button" href="{{ url('system/user/') }}"><i class="angle left icon"></i> Back</a>
        </div>
    </div>
</div>
<div class="ui divider"></div>
{% if status=="successadd" OR status=="success" %}
    <div class="ui positive message">
        <i class="close icon"></i>
        <div class="header">
            {% if status=="successadd" %}
                User has been successfully created
            {% elseif status=="success" %}
                User has been successfully updated
            {% endif %}
        </div>
    </div>
{% endif %}
{% if error.group is defined or error.username is defined or error.name is defined or error.biography is defined or error.email is defined or error.phone is defined or error.gender is defined or error.save is defined %}
    <div class="ui negative message">
        <i class="close icon"></i>
        <div class="header">
            Oops...! Something is missing like :
        </div>
        <ul>
            {% if error.group is defined %}
                <li>group masih kosong</li>
            {% endif %}
            {% if error.username is defined %}
                <li>username masih kosong</li>
            {% endif %}
            {% if error.name is defined %}
                <li>name masih kosong</li>
            {% endif %}
            {% if error.biography is defined %}
                <li>biography masih kosong</li>
            {% endif %}
            {% if error.email is defined %}
                <li>email masih kosong</li>
            {% endif %}
            {% if error.phone is defined %}
                <li>phone masih kosong</li>
            {% endif %}
            {% if error.gender is defined %}
                <li>gender masih kosong</li>
            {% endif %}
            {% if error.save is defined %}
                {% for save in error.save %}
                    <li>{{ save }}</li>
                {% endfor %}
            {% endif %}
        </ul>
    </div>

{% endif %}
<form class="ui form" method="post" action="{{ url('system/user/edit/') }}{{ user.username }}">
    <div class="fields">
        <div class="five wide field">
            <label>Group</label>
            <div class="ui selection dropdown">
                <input type="hidden" name="group" value="{% if request.isPost() %}{{ request.get('group') }}{% else %}{{ user.group_id }}{% endif %}">
                <i class="dropdown icon"></i>
                <div class="default text">Group</div>
                <div class="menu">
                    {% for group in groups %}
                        <div class="item" data-value="{{ group.id }}">{{ group.name }}</div>
                    {% endfor %}
                </div>
            </div>
        </div>
        <div class="three wide field">
            <label>Username</label>
            <input type="text" name="username" placeholder="Username" value="{% if request.isPost() %}{{ request.get('username') }}{% else %}{{ user.username }}{% endif %}" disabled readonly>
        </div>
        <div class="eight wide field">
            <label>Full Name</label>
            <input type="text" name="name" placeholder="Full Name" value="{% if request.isPost() %}{{ request.get('name') }}{% else %}{{ user.name }}{% endif %}">
        </div>
    </div>
    <div class="field">
        <label>Biography</label>
        <textarea name="biography" placeholder="Biography">{% if request.isPost() %}{{ request.get('biography') }}{% else %}{{ user.biography }}{% endif %}</textarea>
    </div>
    <div class="fields">
        <div class="five wide field">
            <label>E-Mail</label>
            <input type="text" name="email" placeholder="E-Mail" value="{% if request.isPost() %}{{ request.get('email') }}{% else %}{{ user.email }}{% endif %}">
        </div>
        <div class="three wide field">
            <label>Phone</label>
            <input type="text" name="phone" placeholder="Phone" value="{% if request.isPost() %}{{ request.get('phone') }}{% else %}{{ user.phone }}{% endif %}">
        </div>
        <div class="three wide field">
            <label>Gender</label>
            <div class="ui selection dropdown" value="{% if request.isPost() %}{{ request.get('gender') }}{% else %}{{ user.gender }}{% endif %}">
                <input type="hidden" name="gender">
                <i class="dropdown icon"></i>
                <div class="default text">Gender</div>
                <div class="menu">
                    <div class="item" data-value="m">Male</div>
                    <div class="item" data-value="f">Female</div>
                </div>
            </div>
        </div>
    </div>
    <div class="field">
        <button type="submit" class="ui magenta button"><i class="save icon"></i> Create</button>
    </div>
</form>

<script>
    $('.ui.form')
        .form({
            fields:{
                group: {
                    identifier  : 'group',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please select your group'
                        }
                    ]
                },
                username: {
                    identifier  : 'username',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please enter your username'
                        }
                    ]
                },
                name: {
                    identifier  : 'name',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please enter your name'
                        }
                    ]
                },
                biography: {
                    identifier  : 'biography',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please enter your biography'
                        }
                    ]
                },
                email: {
                    identifier  : 'email',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please enter your biography'
                        }
                    ]
                },
                phone: {
                    identifier  : 'phone',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please enter your phone'
                        }
                    ]
                },
                gender: {
                    identifier  : 'gender',
                    rules: [
                        {
                            type   : 'empty',
                            prompt : 'please select your gender'
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