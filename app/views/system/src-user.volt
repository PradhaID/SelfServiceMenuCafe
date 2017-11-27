<table class="ui mini magenta striped selectable table">
    <thead>
    <tr>
        <th>Group</th>
        <th>Username</th>
        <th>E-Mail</th>
        <th>Name</th>
        <th>Status</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    {% for user in users %}
        <tr>
            <td>{{ user.group_name }}</td>
            <td>{{ user.username }}</td>
            <td>{{ user.email }}</td>
            <td>{{ user.name }}</td>
            <td>{% if user.status %}Active{% else %}Inactive{% endif %}</td>
            <td><a href="{{ url('system/user/edit/') }}{{  user.username }}"><i class="edit icon"></i> </a></td>
        </tr>
    {% endfor %}
    </tbody>
</table>
<div class="ui divider"></div>